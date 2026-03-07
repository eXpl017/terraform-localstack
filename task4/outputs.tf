output "alb_info" {
  value = {
        dns_name = aws_lb.myalb.dns_name,
        arn = aws_lb.myalb.arn
    }
}

output "generic_info" {
    value = {
        tg_arn = aws_lb_target_group.app_serv_tg.id,
        app_serv_sg_id = local.app_serv_sg_id
    }
}
