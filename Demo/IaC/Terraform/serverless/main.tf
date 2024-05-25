provider "aws" {
  region = "us-east-1"
}

terraform {
  # Tells terraform to use the latest version of the provider AWS
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }
  }
}
