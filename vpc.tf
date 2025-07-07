# import {
#   to = aws_vpc.production
#   id = "vpc-017e50e2343d59083"
# }
resource "aws_vpc" "production" {
  cidr_block = var.cidr_block

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name      = "VPC: us-east"
    ManagedBy = "Terraform"
  }

}

# import {
#   to = aws_subnet.US-E-1A
#   id = "subnet-05fa35519b1c55ad7"
# }
resource "aws_subnet" "US-E-1A" {
  availability_zone = "us-east-1a"
  cidr_block        = "172.31.16.0/20"
  tags = {
    Name      = "US-E-1A"
    ManagedBy = "Terraform"
  }
  vpc_id = "vpc-017e50e2343d59083"
}

# import {
#   to = aws_subnet.US-E-1B
#   id = "subnet-0a537b153058aa222"
# }
resource "aws_subnet" "US-E-1B" {
  availability_zone = "us-east-1b"
  cidr_block        = "172.31.32.0/20"
  tags = {
    Name      = "US-E-1B"
    ManagedBy = "Terraform"
  }
  vpc_id = "vpc-017e50e2343d59083"
}

# import {
#   to = aws_subnet.US-E-1C
#   id = "subnet-0bc1bface04d22115"
# }
resource "aws_subnet" "US-E-1C" {
  availability_zone = "us-east-1c"
  cidr_block        = "172.31.0.0/20"
  tags = {
    Name      = "US-E-1C"
    ManagedBy = "Terraform"
  }
  vpc_id = "vpc-017e50e2343d59083"
}