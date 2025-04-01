provider "aws" {
  region = "us-east-1"  # Puedes cambiar a la región que prefieras
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # ID de una AMI (Amazon Machine Image) válida
  instance_type = "t2.micro"  # Tipo de instancia (puedes ajustarlo según tus necesidades)

  tags = {
    Name = "ExampleInstance"
  }
}
