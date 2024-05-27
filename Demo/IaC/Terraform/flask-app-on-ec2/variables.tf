variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "ec2_instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
}

variable "ec2_instance_name" {
    description = "The name of the EC2 instance"
    type        = string
}

variable "ec2_ami" {
    description = "The AMI to use for the EC2 instance"
    type        = string
}

variable "vpc_tags" {
  description = "A map of tags to assign to the VPC"
  type        = map(string)
}