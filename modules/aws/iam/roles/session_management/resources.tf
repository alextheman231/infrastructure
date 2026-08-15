resource "aws_iam_role" "session_management" {
  name = "${var.name}-session-management"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "ec2.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "session_management" {
  role       = aws_iam_role.session_management.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "session_management" {
  name = "${var.name}-session-management"
  role = aws_iam_role.session_management.name
}
