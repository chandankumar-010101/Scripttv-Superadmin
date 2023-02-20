# Output the frontend URL for other modules to use
output "frontend_url" {
  value = "${aws_lb.frontend_lb.dns_name}"
}
