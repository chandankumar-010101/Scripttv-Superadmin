# Declare the AWS provider configuration
provider "aws" {
  region = var.aws_region
}

# Declare the modules
module "backend" {
  source        = "./backend"
  project_name  = var.project_name
  environment   = var.environment
  aws_region    = var.aws_region
}

module "database" {
  source        = "./database"
  project_name  = var.project_name
  environment   = var.environment
  aws_region    = var.aws_region
}

module "frontend" {
  source                         = "./frontend"
  region                         = var.aws_region
  cluster_name                   = module.backend.cluster_name
  frontend_task_family           = var.project_name
  frontend_container_name        = "frontend-container"
  frontend_image                 = "your-frontend-docker-image-url"
  frontend_cpu                   = 256
  frontend_memory                = 512
  frontend_container_port        = 80
  vpc_id                         = module.backend.vpc_id
  subnets                        = module.backend.private_subnet_ids
  security_group_ids             = [module.backend.security_group_id]
}

# Declare the outputs
output "backend_url" {
  value = module.backend.backend_url
}

output "database_endpoint" {
  value = module.database.endpoint
}

output "frontend_url" {
  value = module.frontend.frontend_url
}
