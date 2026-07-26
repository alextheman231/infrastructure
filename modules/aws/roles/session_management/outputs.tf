output "profile_name" {
  value = aws_iam_instance_profile.session_management.name
}

output "role_name" {
  value = aws_iam_role.session_management.name
}
