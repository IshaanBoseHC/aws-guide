terraform {
  required_version = ">= 1.0.0"
}

resource "random_pet" "example" {
  length = 4
}

resource "null_resource" "example_2" {
  triggers = {
    pet_name = random_pet.example.id
  }

   lifecycle {
    prevent_destroy = true
  }

  
}

# New null resources
resource "null_resource" "new_1" {
  triggers = {
    pet_name = random_pet.example.id
  }
   lifecycle {
    prevent_destroy = true
  }
}

resource "null_resource" "new_2" {
  triggers = {
    pet_name = random_pet.example.id
  }
   lifecycle {
    prevent_destroy = true
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


resource "null_resource" "new_6" {
  triggers = {
    pet_name = random_pet.example.id
  }



  

  provisioner "local-exec" {
     command = "echo creation provisioner was run"
  }
}



resource "aws_instance" "server" {
  count = 4 # create four similar EC2 instances

  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"

  tags = {
    Name = "Server ${count.index}"
  }
}
