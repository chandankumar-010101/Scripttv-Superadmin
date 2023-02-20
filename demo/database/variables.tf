variable "region" {
  description = "The AWS region in which to deploy the database"
}

variable "cluster_name" {
  description = "The name of the ECS cluster for the database"
}

variable "database_task_family" {
  description = "The name of the task family for the database"
}

variable "database_service_name" {
  description = "The name of the ECS service for the database"
}

variable "database_container_name" {
  description = "The name of the container for the database"
}

variable "database_image" {
  description = "The Docker image for the PostgreSQL database"
}

variable "database_cpu" {
  description = "The number of CPU units to reserve for the database container"
}

variable "database_memory" {
  description = "The amount of memory to reserve for the database container"
}

variable "database_container_port" {
  description = "The port on which the database container listens"
}

variable "database_username" {
  description = "The username for the PostgreSQL database"
}

variable "database_password" {
  description = "The password for the PostgreSQL database"
}

variable "database_name" {
  description = "The name of the PostgreSQL database"
}

variable "database_desired_count" {
  description = "The desired number of instances of the database task"
}

variable "vpc_id" {
  description = "The ID of the VPC in which to deploy the database"
}

variable "subnets" {
  description = "The IDs of the subnets in which to deploy the database"
  type        = list(string)
}

variable "security_group_ids" {
  description = "The IDs of the security groups for the database"
  type        = list(string)
}
