# This file allows you to override the default variable values in the `variables.tf` file.
vpc_cidr = "10.4.0.0/20"
ec2_instance_type = "t3.micro"
ec2_instance_name = "terraform-ec2"
ec2_ami = "ami-0bb84b8ffd87024d8"
vpc_tags = {
  "Name" = "terraform-vpc"
}
