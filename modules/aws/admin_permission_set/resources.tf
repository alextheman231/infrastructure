resource "aws_ssoadmin_permission_set" "administrator" {
  instance_arn = var.instance_arn

  name             = "AdministratorAccess"
  description      = "Full administrative access."
  session_duration = "PT12H"
}
