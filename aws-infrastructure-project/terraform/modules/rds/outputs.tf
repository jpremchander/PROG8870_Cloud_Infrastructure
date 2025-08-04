output "db_instance_endpoint" {
  value = aws_db_instance.my_db_instance.endpoint
}

output "db_instance_identifier" {
  value = aws_db_instance.my_db_instance.id
}

output "db_instance_port" {
  value = aws_db_instance.my_db_instance.port
}

output "db_instance_username" {
  value = aws_db_instance.my_db_instance.username
}