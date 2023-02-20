variable "region" {
  description = "The AWS region in which to deploy the backend"
}

variable "cluster_name" {
  description = "The name of the ECS cluster for the backend"
}

variable "backend_task_family" {
  description = "The name of the task family for the backend"
}

variable "backend_service_name" {
  description = "The name of the ECS service for the backend"
}

variable "backend_container_name" {
  description = "The name of the container for the backend"
}

variable "backend_image" {
  description = "The Docker image for the backend"
}

variable "backend_cpu" {
  description = "The number of CPU units to reserve for the backend container"
}

variable "backend_memory" {
  description = "The amount of memory to reserve for the backend container"
}

variable "backend_container_port" {
  description = "The port on which the backend container listens"
}

variable "backend_desired_count" {
  description = "The desired number of instances of the backend task"
}

variable "vpc_id" {
  description = "The ID of the VPC in which to deploy the backend"
}

variable "subnets" {
  description = "The IDs of the subnets in which to deploy the backend"
  type        = list(string)
}

variable "security_group_ids" {
  description = "The IDs of the security groups for the backend"
  type        = list(string)
}
