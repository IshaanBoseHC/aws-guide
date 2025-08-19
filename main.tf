terraform {
  required_version = ">= 1.0.0"
}

resource "random_pet" "example" {
  length = 4
  count  = 10
}

resource "null_resource" "example_with_pet" {
  count = 10

  triggers = {
    pet_name = random_pet.example[count.index].id
  }

 

  provisioner "local-exec" {
    command = "echo Pet name is ${random_pet.example[count.index].id}"
  }
}
