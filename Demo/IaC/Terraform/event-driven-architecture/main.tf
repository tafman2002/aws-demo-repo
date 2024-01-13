provider "aws" {
  region = var.aws_region
}

resource "random_pet" "lamdba_bucket_name" {
  prefix = "my-terraform-code"
  length = 4
}

resource "aws_s3_bucket" "lambda_bucket" {
  bucket = random_pet.lamdba_bucket_name.id
}

# Creates an SQS queue
resource "aws_sqs_queue" "message_queue" {
  name = "my-message-queue"
}



data "archieve_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "lambda"
  output_path = "lambda.zip"
}

resource "aws_lambda_function" "lambda-function" {
  function_name = "my-lambda-function"
  runtime = "python3.9"
  handler = "handler"
  timeout = 10
  role = aws_iam_role.lambda-role-execution.arn
  memory_size = 128
  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.lambda_bucket.id
    }
  }

}