output "vpc_id" {
  value = aws_vpc.demonstration-vpc.id
}

output "ec2_instance_id" {
  value = aws_instance.app_server.id
}

output "ec2_http_endpoint" {
  value = format("http://%s/", aws_instance.app_server.public_ip)
}
