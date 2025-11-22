output "frontend_public_ip" {
  value = aws_instance.frontend.public_ip
}

output "backend_public_ip" {
  value = aws_instance.backend.public_ip
}

output "rds_endpoint" {
  value = aws_rds_cluster.aurora_mysql.endpoint
}

output "db_username" {
  value = aws_rds_cluster.aurora_mysql.master_username
}

output "db_password" {
  value     = random_password.db_password.result
  sensitive = true
}
