# Output the URL for the frontend load balancer
output "frontend_url" {
  value = "http://${aws_lb.frontend.dns_name}:${var.frontend_container_port}"
}
