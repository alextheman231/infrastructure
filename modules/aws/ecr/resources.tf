resource "aws_ecr_repository" "default" {
  name = var.name
}

resource "aws_ecr_lifecycle_policy" "default" {
  repository = aws_ecr_repository.default.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images older than 7 days."
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = var.expire_untagged_images_after_days
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
