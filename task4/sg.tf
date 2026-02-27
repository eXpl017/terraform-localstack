resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "Security group for ALB"
  vpc_id      = local.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "alb_ingress_rule" {
  count = length(var.alb_allow_ports)

  security_group_id = aws_security_group.alb_sg.id
  description       = "Add ingress rule to allow TCP traffic from internet on port ${var.alb_allow_ports[count.index]}"

  cidr_ipv4   = var.internet_cidr
  from_port   = var.alb_allow_ports[count.index]
  to_port     = var.alb_allow_ports[count.index]
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "alb_egress_rule" {
  count = length(var.alb_allow_ports)

  security_group_id = aws_security_group.alb_sg.id
  description       = "Add egress rule to allow TCP traffic from ALB to AppServer's security group on port ${var.alb_allow_ports[count.index]}"

  referenced_security_group_id = local.app_serv_sg_id
  from_port                    = var.alb_allow_ports[count.index]
  to_port                      = var.alb_allow_ports[count.index]
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "app_serv_ingress_rule" {
  count = length(var.alb_allow_ports)

  security_group_id = local.app_serv_sg_id
  description       = "Add ingress rule to allow TCP traffic from ALB on port ${var.alb_allow_ports[count.index]}"

  referenced_security_group_id = aws_security_group.alb_sg.id
  from_port                    = var.alb_allow_ports[count.index]
  to_port                      = var.alb_allow_ports[count.index]
  ip_protocol                  = "tcp"
}
