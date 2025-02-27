resource "aws_iam_role" "app_runner_auth_role" {
  name = "${var.prefix}-AppRunnerAuthRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = { Service = "build.apprunner.amazonaws.com" },
        Action    = "sts:AssumeRole"
      }
    ]
  })
}
resource "aws_iam_role" "app_runner_instance_role" {
  name = "${var.prefix}-AppRunnerInstanceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = { Service = "tasks.apprunner.amazonaws.com" },
        Action    = "sts:AssumeRole"
      }
    ]
  })
}
resource "aws_iam_policy" "app_runner_policy" {
  name        = "${var.prefix}-AppRunnerServicePolicy"
  description = "Policy for AWS App Runner to access ECR, replicating the AWS managed policy"
  policy      = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:DescribeImages",
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "app_runner_auth_policy_attach" {
  role       = aws_iam_role.app_runner_auth_role.name
  policy_arn = aws_iam_policy.app_runner_policy.arn
}

resource "aws_apprunner_service" "app" {
  service_name = "${var.prefix}-app-runner"

  source_configuration {
    authentication_configuration {
      access_role_arn = aws_iam_role.app_runner_auth_role.arn
    }

    image_repository {
      image_identifier      = "${var.repository_url}:latest"
      image_repository_type = "ECR"
      image_configuration {
        port = "8080"
      }
    }
    auto_deployments_enabled = true
  }

  instance_configuration {
    cpu    = "1024"
    memory = "2048"
    instance_role_arn = aws_iam_role.app_runner_instance_role.arn
  }

  observability_configuration {
    observability_enabled = false
  }

  tags = {
    Name = "${var.prefix}-app-runner"
    IAC  = "True"
  }
}