resource "aws_iam_policy" "bucket_policy" {
  name        = "s3-bucket-policy"
  description = "Allow"
  path        = "/"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Action" : [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ],
      "Resource" : [
        aws_s3_bucket.mybucket.arn,
        "${aws_s3_bucket.mybucket.arn}/*"
      ]
    }]
  })
}

resource "aws_iam_policy" "dbtable_policy" {
  name        = "dynamo-table-policy"
  description = "Allow access"
  path        = "/"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Action" : [
        "dynamodb:GetItem",
        "dynamodb:Query",
        "dynamodb:DescribeTable"
      ],
      "Resource" : aws_dynamodb_table.mytable.arn
    }]
  })
}
