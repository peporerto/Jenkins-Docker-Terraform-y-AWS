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


provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_security_group" "jenkins_sg" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins_ec2" {
  ami                    = "ami-071226ecf16aa7d96"  # Amazon Linux 2023
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  key_name               = "mi-clave-ssh"  # Cambia esto por tu clave SSH

  user_data = file("user-data.sh")

  tags = {
    Name = "JenkinsServer"
  }
}
