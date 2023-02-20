# # Define variables that will be used across all modules
# variable "aws_region" {
#   description = "The AWS region in which to deploy the application"
# }

# variable "project_name" {
#   description = "The name of the project"
# }

# variable "environment" {
#   description = "The name of the environment (e.g. staging, production)"
# }

# # Declare variables specific to each module
# module "backend" {
#   source        = "./backend"
#   project_name  = var.project_name
#   environment   = var.environment
#   aws_region    = var.aws_region
# }

# module "database" {
#   source        = "./database"
#   project_name  = var.project_name
#   environment   = var.environment
#   aws_region    = var.aws_region
# }

# module "frontend" {
#   source                         = "./frontend"
#   region                         = var.aws_region
#   cluster_name                   = module.backend.cluster_name
#   frontend_task_family           = var.project_name
#   frontend_container_name        = "frontend-container"
#   frontend_image                 = "your-frontend-docker-image-url"
#   frontend_cpu                   = 256
#   frontend_memory                = 512
#   frontend_container_port        = 80
#   vpc_id                         = module.backend.vpc_id
#   subnets                        = module.backend.private_subnet_ids
#   security_group_ids             = [module.backend.security_group_id]
# }
################################################

# Define variables that will be used across all modules
variable "aws_region" {
  description = "The AWS region in which to deploy the application"
}

variable "project_name" {
  description = "The name of the project"
}

variable "environment" {
  description = "The name of the environment (e.g. staging, production)"
}

# Declare variables specific to the backend module
module "backend" {
  source                = "./backend"
  project_name          = var.project_name
  environment           = var.environment
  aws_region            = var.aws_region
  backend_image         = "chandan010101/invo:latest"
  backend_cpu           = 256
  backend_memory        = 512
  backend_container_port = 8080
}

# Declare variables specific to the database module
module "database" {
  source                  = "./database"
  project_name            = var.project_name
  environment             = var.environment
  aws_region              = var.aws_region
  cluster_name            = module.backend.cluster_name
  database_task_family    = var.project_name
  database_service_name   = "my-postgres-secret"
  database_container_name = "database-container"
  database_image          = "postgres:latest"
  database_cpu            = 256
  database_memory         = 512
  database_container_port = 5432
  database_username       = "postgres"
  database_password       = "postgres"
  database_name           = "kubernetes_django"
  database_desired_count  = 1
  vpc_id                  = module.backend.vpc_id
  subnets                 = module.backend.private_subnet_ids
  security_group_ids      = [module.backend.security_group_id]
}

# Declare variables specific to the frontend module
module "frontend" {
  source                         = "./frontend"
  region                         = var.aws_region
  cluster_name                   = module.backend.cluster_name
  frontend_task_family           = var.project_name
  frontend_container_name        = "frontend-container"
  frontend_image                 = "chandan010101/fs:latest"
  frontend_cpu                   = 256
  frontend_memory                = 512
  frontend_container_port        = 80
  vpc_id                         = module.backend.vpc_id
  subnets                        = module.backend.private_subnet_ids
  security_group_ids             = [module.backend.security_group_id]
}
