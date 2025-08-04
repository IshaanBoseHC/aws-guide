terraform {
  required_version = ">= 1.0.0"
}

resource "random_pet" "example" {
  length = 4
  count  = 100
}

resource "null_resource" "example_with_pet" {
  count = 100

  triggers = {
    pet_name = random_pet.example[count.index].id
  }

  lifecycle {
    prevent_destroy = true
  }

  provisioner "local-exec" {
    command = "echo Pet name is ${random_pet.example[count.index].id}"
  }
}
