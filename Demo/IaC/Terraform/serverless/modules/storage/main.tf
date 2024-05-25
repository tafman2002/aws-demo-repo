resource "aws_s3_bucket" "src_bucket" {
  bucket = var.src_bucket_name
  tags = {
    environment = var.tag_environment
  }
}

resource "aws_s3_bucket" "dst_bucket" {
  bucket = var.dst_bucket_name
  tags = {
    environment = var.tag_environment
  }
}