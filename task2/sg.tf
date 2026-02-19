resource "aws_security_group" "bastion_sg" {
  name        = "bastion_sg"
  description = "Allow all outbound conn. Allow only incoming ssh conn from specfic IP"
  vpc_id      = local.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.internet_cidr]
  }
}

resource "aws_security_group" "app_serv_sg" {
  name        = "app_serv_sg"
  description = "Allow all outbound conn. Allow only incoming ssh conn from bastion host"
  vpc_id      = local.vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.internet_cidr]
  }
}
