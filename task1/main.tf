provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "vpc1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc1"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet-a"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "subnet-b"
  }
}

resource "aws_instance" "server_a" {
  ami           = "ami-04b938437b69a2c9c"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.subnet_a.id
  lifecycle {

    prevent_destroy = true
    ignore_changes = [
    tags]


  }
  tags = {
  Name = "server-a" }
}

resource "aws_instance" "server_b" {
  ami           = "ami-04b938437b69a2c9c"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.subnet_b.id

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
    tags]
  }
  tags = {
  Name = "server-b" }
}


VPC is created

