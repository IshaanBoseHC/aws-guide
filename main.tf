terraform {
  required_version = ">= 1.0.0"
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = ">= 3.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}

resource "random_pet" "example" {
  length = 2
}

resource "null_resource" "example" {
  triggers = {
    pet_name = random_pet.example.id
  }
}