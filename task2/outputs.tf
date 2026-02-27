output "bastion_pub_ip" {
  value = { for key, host in aws_instance.bastion_host : host.availability_zone => host.public_ip }
}

output "app_serv_priv_ip" {
  value = { for key, host in aws_instance.app_server : host.availability_zone => host.private_ip }
}

output "sg_ids" {
  value = {
    bastion_sg  = aws_security_group.bastion_sg.id
    app_serv_sg = aws_security_group.app_serv_sg.id
  }
}

output "app_serv_instance_id" {
    value = [ for host in aws_instance.app_server : host.id ]
}
