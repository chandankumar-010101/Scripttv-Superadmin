variable "region" {
  description = "The AWS region in which to deploy the frontend"
}

variable "cluster_name" {
  description = "The name of the ECS cluster for the frontend"
}

variable "frontend_task_family" {
  description = "The name of the task family for the frontend"
}

variable "frontend_container_name" {
  description = "The name of the container for the frontend"
}

variable "frontend_image" {
  description = "The Docker image for the frontend"
}

variable "frontend_cpu" {
  description = "The number of CPU units to reserve for the frontend container"
}

variable "frontend_memory" {
  description = "The amount of memory to reserve for the frontend container"
}

variable "frontend_container_port" {
  description = "The port on which the frontend container listens"
}

variable "vpc_id" {
  description = "The ID of the VPC in which to deploy the frontend"
}

variable "subnets" {
  description = "The IDs of the subnets in which to deploy the frontend"
  type        = list(string)
}

variable "security_group_ids" {
  description = "The IDs of the security groups for the frontend"
  type        = list(string)
}
