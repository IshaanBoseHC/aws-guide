# main.tf

variable "aws_region" {
  type        = string
  description = "The AWS region to create the role in."
 default     = "us-east-2"
 }

variable "tf_organization" {
  type        = string
  description = "The name of the organization that this workspace and Stack live in."
     default     = "IshaansTesterOrganization"

}

variable "tf_project" {
  type        = string
  description = "The name of the project that this workspace and Stack live in."
   default     = "Default Project"

}

variable "tf_stack" {
  type        = string
  description = "The name of the Stack you will you use this token in."
     default     = "stack1"

}

provider "aws" {
  region = var.aws_region
}

resource "aws_iam_openid_connect_provider" "stacks_openid_provider" {
  url            = "https://app.terraform.io"
  client_id_list = ["aws.workload.identity"]

  # This is the thumbprint of https://app.terraform.io as of 2024/08/07
  # Refer to "Adjust access of trust" to learn how to update this thumbprint
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
}

resource "aws_iam_role" "stacks_role" {
  name               = "stacks-${var.tf_organization}-${var.tf_project}-${var.tf_stack}"
  assume_role_policy = data.aws_iam_policy_document.stacks_role_policy.json
}

data "aws_iam_policy_document" "stacks_role_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.stacks_openid_provider.arn]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = "app.terraform.io:aud"
      values   = ["aws.workload.identity"]
    }
    condition {
      test     = "StringLike"
      variable = "app.terraform.io:sub"
      # This value dictates which HCP Terraform organizations, projects,  
      # and stacks can assume the new role you are creating.
      # 
      # You can widen access to an entire organization or project by
      # tweaking the value below. You can also restrict access to specific
      # deployments or operations. Refer to Configure trust for more information.
      values = ["organization:${var.tf_organization}:project:${var.tf_project}:stack:${var.tf_stack}:*"]
    }
  }
}

# Now, you give the new role access to things you want to manage in your Stack.
#
# The policies below are too broad for a production use case, but you set them 
# broadly for now to ensure this Stacks can do anything during development and 
# testing. In practice, only give your Stack access to what it needs to manage.

resource "aws_iam_role_policy_attachment" "iam" {
  role       = aws_iam_role.stacks_role.name
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

resource "aws_iam_role_policy_attachment" "sudo" {
  role       = aws_iam_role.stacks_role.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

# Your workspace returns this output role, which you use to configure your 
# deployments. 
output "role_arn" {
  value = aws_iam_role.stacks_role.arn
}
