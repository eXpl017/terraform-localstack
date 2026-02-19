resource "aws_key_pair" "deployer" {
  key_name   = "deployer_key"
  public_key = file(var.pubkey_path)
}

resource "aws_instance" "bastion_host" {
  ami                         = local.ami_id
  instance_type               = var.serv_type["bastion"]
  subnet_id                   = local.subnet_ids["public"]
  key_name                    = aws_key_pair.deployer.key_name
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true
  tags = {
    Name = "Bastion host in public subnet"
  }
}

resource "aws_instance" "app_server" {
  ami                    = local.ami_id
  instance_type          = var.serv_type["app"]
  subnet_id              = local.subnet_ids["private"]
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.app_serv_sg.id]
  tags = {
    Name = "App server instance in private subnet"
  }
}
