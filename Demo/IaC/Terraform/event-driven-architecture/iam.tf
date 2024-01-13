resource "aws_iam_role" "lambda-role-execution" {
  name  = "lambda-role-execution"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "lambda-policy" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": "${aws_s3_bucket.lambda_bucket.arn}/*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "sqs:SendMessage"
        "sqs:ReceiveMessage"
        "sqs:DeleteMessage"
        "sqs:GetQueueAttributes"
      ],
      "Resource": "${aws_sqs_queue.message_queue.arn}",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "lambda_bucket_policy" {
  bucket = aws_s3_bucket.lambda_bucket.id
  policy = <<EOF
  {
   "Version": "2012-10-17",
   "Statement": [
     {
       "Sid": "AddPerm",
       "Effect": "Allow",
       "Principal": "*",
       "Action": [
        "s3:GetObject",
        "s3:PutObject"
        ],
       "Resource": "${aws_s3_bucket.lambda_bucket.arn}/*"
     }
   ]
  EOF
}