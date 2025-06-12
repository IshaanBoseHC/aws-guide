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
  length = 4  # Modified the length of the random pet
}

resource "null_resource" "example_2" {  # Renamed the existing null resource
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
    pet_name = random_pet.example.id
  }
}

resource "null_resource" "new_4" {
  triggers = {
    pet_name = random_pet.example.id
  }
}

resource "null_resource" "new_5" {
  triggers = {
    pet_name = random_pet.example.id
  }
}
