   
resource "random_id" "random_id_prefix" {
  byte_length = 2
}
/*====
Variables used across all modules
======*/

// production_availability_zones covers the az's for the given region
locals {
  production_availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
}

module "networking" {
  source = "./modules/networking"

  region               = "${var.region}"
  environment          = "${var.environment}"
  vpc_cidr             = "${var.vpc_cidr}"
  public_subnets_cidr  = "${var.public_subnets_cidr}"
  private_subnets_cidr = "${var.private_subnets_cidr}"
  availability_zones   = "${local.production_availability_zones}"
}

resource "aws_key_pair" "pipelinekey" {
  key_name   = "pipelinekey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9yP4OxkB7m35/+KskP/KI59AOWAUnWW8nOaVvsnoN/d3/B055bZN546G3lVi/n+LjLTQqsDtuzH1QTVBQoTjkZykoNbi20M6lqZbEBL7CKnEqAcYQgzAL6o1WU33axrwgWEqMAzxsuWMH6yMwKmkaPiUDWi3hRhpMxDK0ZUbR8VGANvNn7OiFidPKf7s2Y581KFRu9UexS31Iahhnya1fIlD5Fgg0FNIJtyw4c02WvVXK4qkAYoavcdahMBo8YYmNO2E0MwnpY50bC+q7oQNN8esrr89cjkuYegYyPborD6i1kS63HeotXNS1HrWVhWENPgHI+T0RjXhLLreSQ60ZvO9c0P7bf36pHEYd7Fr1sK0VprODM2BrC947OoY8eq24AtgphF6MYv5lcGurzlVZoywK/PvWf0ARWE13PJV2v4PBl9FUPPS0NYwyo8QMqD2sdaaXn8gvVWjlEWlXdPXRM4RTTQ9vZKyjCa0cHLCCzogd3b+VZVMHKE5RJ7RDqhU= chris@Chriss-MBP"
}

/*resource "aws_instance" "ansible-controller" {
    ami = "ami-0c2d06d50ce30b442"
    instance_type = "t3.micro"
    key_name = "pipelinekey"
    vpc_security_group_ids = [
        "sg-09845319f5212ebdb",
    ]
    subnet_id = "subnet-08b34138d71309add"

    tags = {
        Name = "ansible-controller"
    }  
}

resource "aws_instance" "ansible-db" {
    ami = "ami-0c2d06d50ce30b442"
    instance_type = "t3.micro"
    key_name = "pipelinekey"
    vpc_security_group_ids = [
        "sg-09845319f5212ebdb",
    ]
    subnet_id = "subnet-08b34138d71309add"

    tags = {
        Name = "ansible-db"
    }  
}*/