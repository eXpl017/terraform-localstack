output "bastion_pub_ip" {
  value = aws_instance.bastion_host.public_ip
}

output "app_serv_priv_ip" {
  value = aws_instance.app_server.private_ip
}

output "sg_ids" {
  value = {
    bastion_sg  = aws_security_group.bastion_sg.id
    app_serv_sg = aws_security_group.app_serv_sg.id
  }
}
