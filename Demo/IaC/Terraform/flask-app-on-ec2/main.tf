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

# Creates a VPC
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

resource "aws_subnet" "public-subnet-A" {
  vpc_id = aws_vpc.demonstration-vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name = "terraform-demo-public-subnet"
  }
}

resource "aws_subnet" "private-subnet-A" {
  vpc_id = aws_vpc.demonstration-vpc.id
  tags = {
    Name = "terraform-private-subnet"
  }
}

# Creates a ec2_instance profile role and attaches the necessary policies
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
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  ]
}

resource "aws_iam_instance_profile" "web-server-ip" {
  name = "web-server-ip"
  role = aws_iam_role.web-server-role.name
}

resource "aws_security_group" "app-sg" {
  name = "Terraform-HTTP"
  vpc_id = aws_vpc.demonstration-vpc.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# App Server on EC2
resource "aws_instance" "app_server" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  subnet_id = aws_subnet.public-subnet-A.id
  vpc_security_group_ids = [aws_security_group.app-sg.id]
  user_data = base64encode(<<EOF
    #!/bin/bash
    sudo yum install python3 -y
    python3 -m venv myenv
    source myenv/bin/activate
    pip install flask gunicorn
    echo "from flask import Flask
    app = Flask(__name__)

    @app.route('/')
    def hello_world():
        return '<h1>Hello, World!</h1>'

    if __name__ == '__main__':
        app.run(host='0.0.0.0', port=80)" > app.py
    gunicorn -w 4 -b 0.0.0.0:80 app:app
    EOF
  )
  tags = {
    Name = var.ec2_instance_name
  }
}