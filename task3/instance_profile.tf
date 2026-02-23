resource "aws_iam_instance_profile" "app_serv_profile" {
  name = "app-server-instance-profile"
  role = aws_iam_role.resource_access_role.name
}
