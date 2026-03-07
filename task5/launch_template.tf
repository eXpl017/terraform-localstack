resource "aws_key_pair" "ag_mnged" {
  key_name   = "ag-managed-ec2"
  public_key = file(var.pubkey_path)
}

resource "aws_launch_template" "ec2_lt" {
  name          = "my_launch_tmpl"
  description   = "Launch template for EC2 instance in private subnets in 2 AZs"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ag_mnged.key_name
    vpc_security_group_ids = [local.app_serv_sg_id]

  iam_instance_profile {
    arn = local.instance_profile
  }

  monitoring {
    enabled = true
  }

}
