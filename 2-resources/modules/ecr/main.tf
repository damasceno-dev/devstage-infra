resource "aws_ecr_repository" "ecr" {
  name                 = "${var.prefix}-ecr-repository"
  image_tag_mutability = "MUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  force_delete = true

  tags = {
    Name = "${var.prefix}-ecr"
    IAC  = "True"
  }
}

resource "aws_ecr_lifecycle_policy" "ecr_policy" {
  repository = aws_ecr_repository.ecr.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Expire untagged images after 7 days",
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 7
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}