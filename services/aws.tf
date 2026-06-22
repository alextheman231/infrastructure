module "aws_repository" {
  source       = "../modules/aws"
  instance_arn = var.aws_instance_arn
}
