output "rds_endpoint" {
  value = aws_db_instance.rds.endpoint
}

output "rds_security_group_id" {
  value = aws_security_group.rds_sg.id
}
output "rds_vpc_id" {
  value = var.vpc_id  # ✅ Debugging step
}