variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_tags" {
    description = "A map of tags to assign to the VPC"
    type        = map(string)
}