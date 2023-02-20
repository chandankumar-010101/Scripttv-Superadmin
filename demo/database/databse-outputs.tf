# Output the database endpoint for other modules to use
output "endpoint" {
  value = aws_rds_cluster.endpoint
}
