terraform {
  # Tells terraform to use the latest version of the provider AWS
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.51.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "demonstration-vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = var.vpc_tags
}


resource "aws_internet_gateway" "internet-gateway" {
    vpc_id = aws_vpc.demonstration-vpc.id
    tags = {
        Name = "terraform-demo-ig"
    }
}

resource "aws_route_table" "route-table-public" {
  vpc_id = aws_vpc.demonstration-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.demonstration-vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name = "terraform-demo-public-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.demonstration-vpc.id
    tags = {
        Name = "terraform-demo-private-subnet"
    }
}

#resource "aws_budgets_budget" "keep-costs-low" {
#  budget_type       = "COST"
#  limit_amount      = "20"
#  limit_unit        = "USD"
#  time_unit         = "MONTHLY"
#  time_period_start = "2024-01-01_00:00"
#}

resource "aws_iam_role" "web-server-role" {
  name = "web-server-role"
  path = "/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  ]
}

resource "aws_iam_instance_profile" "web-server-ip" {
  name = "web-server-ip"
  role = aws_iam_role.web-server-role.name
}