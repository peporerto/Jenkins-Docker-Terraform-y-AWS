variable "aws_region" {
  description = "Region for the VPC"
  default     = "us-east-1"  # Cambia la región si es necesario
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  default     = "10.0.2.0/24"
}

variable "ami" {
  description = "Amazon Linux AMI"
  default     = "ami-00a929b66ed6e0de6"  # Cambia la AMI según tu región
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "C:/Users/eliso/.ssh/id_rsa.pub"
}
