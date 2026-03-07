resource "aws_autoscaling_group" "myasg" {
  name                      = "my-asg"
  max_size                  = 5
  min_size                  = 2
  desired_capacity          = 4
  health_check_type         = "ELB"
  health_check_grace_period = 300
  vpc_zone_identifier       = local.private_subnets
  target_group_arns         = [local.app_tg_grp_arn]
  termination_policies      = ["OldestInstance"]

    launch_template {
    id = aws_launch_template.ec2_lt.id
    version = "$Latest"
}


}
