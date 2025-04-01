provider "aws" {
  region = "us-east-1"  # Puedes cambiar a la región que prefieras
}

resource "aws_instance" "example" {
  ami           = "ami-071226ecf16aa7d96"  # ID de AMI de Amazon Linux 2023
  instance_type = "t2.micro"  # Tipo de instancia (puedes ajustarlo según tus necesidades)

  tags = {
    Name = "ExampleInstance"
  }
}
