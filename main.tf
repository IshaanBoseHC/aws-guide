terraform {
  required_version = ">= 1.0.0"

  
}

provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "learn-terraform"
  }
}


module "consul" {
  source  = "app.terraform.io/hashicorp-v2/consul/aws"
  version = "0.7.2"
  # insert required variables here
}

resource "random_pet" "example" {
  length = 4
}

resource "null_resource" "example_2" {
  triggers = {
    pet_name = random_pet.example.id
  }
}

# New null resources
resource "null_resource" "new_1" {
  triggers = {
    pet_name = random_pet.example.id
  }
}

resource "null_resource" "new_2" {
  triggers = {
    pet_name = random_pet.example.id
  }
}

resource "null_resource" "new_3" {
  triggers = {
    pet_name = null
  }
}

resource "null_resource" "new_4" {
  triggers = {
    pet_name = null
  }
}

resource "null_resource" "new_5" {
  triggers = {
    pet_name = random_pet.example.id
  }
}

resource "null_resource" "new_6" {
  triggers = {
    pet_name = random_pet.example.id
  }
}

resource "null_resource" "new_9" {
  triggers = {
    pet_name = random_pet.example.id
  }
}

resource "null_resource" "new_57 {
  triggers = {
    pet_name = random_pet.example.id
  }
}
