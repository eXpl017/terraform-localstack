resource "aws_s3_bucket_policy" "allow_alb_log_write" {
  bucket = aws_s3_bucket.log_bucket.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "elasticloadbalancing.amazonaws.com"
      },
      "Action" : [
        "s3:GetBucketAcl",
        "s3:PutObject"
      ],
      "Resource" : [
        aws_s3_bucket.log_bucket.arn,
        "${aws_s3_bucket.log_bucket.arn}/*"
      ]
    }]
  })
}
