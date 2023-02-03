provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "default-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.default.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_instance" "webapp" {
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.public.id

  tags = {
    Name = "webapp"
  }
}

resource "aws_ecr_repository" "webapp" {
  name = "webapp"
}

resource "aws_ecr_repository" "mysql" {
  name = "mysql"
}
