variable "aws_region" {
  default = "us-east-1"
}

variable "aws_profile" {
  default = "default"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  description = "Amazon Linux 2023"
  default     = "ami-071226ecf16aa7d96"
}

variable "key_name" {
  default = "mi-clave-ssh"
}