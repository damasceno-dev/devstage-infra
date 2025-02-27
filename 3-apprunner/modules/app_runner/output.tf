output "app_runner_service_url" {
  value       = aws_apprunner_service.app.service_url
  description = "The public URL of the AWS App Runner service"
}