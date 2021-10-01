terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.60.0"
    }
  }
}

provider "aws" {
  region  = var.region
}

data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS ENA 2002_*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners =["aws-marketplace"]
}

resource "aws_instance" "ansible-web" {
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "t2.micro"
  key_name = "pipelinekey"
    vpc_security_group_ids = [
        "sg-09845319f5212ebdb",
    ]
    subnet_id = "subnet-08b34138d71309add"

  tags = {
    Name = "ansible-web"
  }
}

resource "aws_instance" "ansible-db" {
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "t2.micro"
  key_name = "pipelinekey"
    vpc_security_group_ids = [
        "sg-09845319f5212ebdb",
    ]
    subnet_id = "subnet-08b34138d71309add"
    
  tags = {
    Name = "ansible-db"
  }
}

resource "aws_instance" "ansible-controller" {
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "t2.micro"
  key_name = "pipelinekey"
    vpc_security_group_ids = [
        "sg-09845319f5212ebdb",
    ]
    subnet_id = "subnet-08b34138d71309add"
    
  tags = {
    Name = "ansible-controller"
  }
}