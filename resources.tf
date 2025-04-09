resource "aws_key_pair" "default" {
  key_name   = "mumbai"
  public_key = file(var.key_path)
}

resource "aws_instance" "wb" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.default.key_name
  subnet_id              = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.sgweb.id]
  associate_public_ip_address = true
  user_data = file("userdata.sh")

  tags = {
    Name = "Webserver"
  }
}

resource "aws_instance" "db" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.default.key_name
  subnet_id              = aws_subnet.private-subnet.id
  vpc_security_group_ids = [aws_security_group.sgdb.id]

  tags = {
    Name = "Database"
  }
}
