# Declare the outputs that will be used outside the module
output "backend_url" {
  value = module.backend.backend_url
}

output "database_endpoint" {
  value = module.database.endpoint
}

output "frontend_url" {
  value = module.frontend.frontend_url
}
