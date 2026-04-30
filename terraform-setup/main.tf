terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Data source to fetch the latest Ubuntu 22.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# Security group allowing SSH
resource "aws_security_group" "ansible_sg" {
  name        = "ansible_lab_sg"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Web Servers (web01, web02)
resource "aws_instance" "web" {
  count                  = 2
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.ansible_sg.id]
  key_name               = "key-asus"

  tags = {
    Name = "web0${count.index + 1}"
  }
}

# Database Server (db01)
resource "aws_instance" "db" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.ansible_sg.id]
  key_name               = "key-asus"

  tags = {
    Name = "db01"
  }
}

output "web_ips" {
  value = aws_instance.web[*].public_ip
}

output "db_ip" {
  value = aws_instance.db.public_ip
}