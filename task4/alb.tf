resource "aws_lb" "myalb" {
  name               = "myalb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = local.subnet_ids["public"]

  access_logs {
    bucket  = aws_s3_bucket.log_bucket.id
    enabled = true
  }

  health_check_logs {
    bucket  = aws_s3_bucket.log_bucket.id
    enabled = true
  }

  tags = {
    Name = "App Load Balancer for servers in 2 AZs"
  }
}
