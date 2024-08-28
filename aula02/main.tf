terraform {
    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = "~> 4.16"
        }
    }
    required_version = ">= 1.2.0"
}
  
provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "ec2-iac-aula2" {
    ami = "ami-0e86e20dae9224db8"
    instance_type = "t2.micro"
    tags = {
        Name = "ec2-iac-aula2"
    }
    ebs_block_device {
      device_name = "/dev/sda1"
      volume_size = 30
      volume_type = "gp3"
    }
    security_groups = [aws_security_group.sg_iac_aula2.name, "default"]
    key_name = "aula_iac"
    subnet_id = aws_subnet.minha_subrede.id
}

variable "porta_http" {
    description = "porta http"
    default = 80
    type = number
}

resource "aws_security_group" "sg_iac_aula2" {
    name = "sg_iac_aula2"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = var.porta_http
        to_port = var.porta_http
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = var.porta_http
        to_port = var.porta_http
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "sg_iac_aula2"
    }
    vpc_id = aws_vpc.minha_rede.id
}

resource "aws_vpc" "minha_rede" {
    cidr_block = "10.10.10.0/24"
}

resource "aws_subnet" "minha_subrede" {
    vpc_id = aws_vpc.minha_rede.id
    cidr_block = "10.10.10.0/24"
}