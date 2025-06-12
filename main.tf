terraform {
  required_version = ">= 1.0.0"
}

resource "random_pet" "example" {
  length = 2
}

resource "null_resource" "example" {
  triggers = {
    pet_name = random_pet.example.id
  }
}
