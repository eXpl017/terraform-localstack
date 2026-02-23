resource "aws_iam_role" "resource_access_role" {
  name = "access_role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "ec2.amazonaws.com"
      },
      "Action" : "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "bucket_policy_attach" {
  role       = aws_iam_role.resource_access_role.name
  policy_arn = aws_iam_policy.bucket_policy.arn
}

resource "aws_iam_role_policy_attachment" "dynamo_policy_attach" {
  role       = aws_iam_role.resource_access_role.name
  policy_arn = aws_iam_policy.dbtable_policy.arn
}
