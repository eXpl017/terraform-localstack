resource "aws_lb_target_group" "app_serv_tg" {
  name                          = "app-servers-target-group"
  load_balancing_algorithm_type = "least_outstanding_requests"
  port                          = 80
  protocol                      = "HTTP"
  slow_start                    = 30
  target_type                   = "instance"
  vpc_id                        = local.vpc_id
}

resource "aws_lb_target_group_attachment" "app_serv_tg" {
  count = length(local.app_serv_instance_ids)

  target_group_arn = aws_lb_target_group.app_serv_tg.arn
  target_id        = local.app_serv_instance_ids[count.index]
  port             = 80
}
