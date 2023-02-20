# Define the ECS task definition for the frontend
resource "aws_ecs_task_definition" "frontend" {
  family                   = var.frontend_task_family
  container_definitions    = jsonencode([
    {
      name            = var.frontend_container_name
      image           = var.frontend_image
      cpu             = var.frontend_cpu
      memory          = var.frontend_memory
      portMappings    = [
        {
          containerPort = var.frontend_container_port
          hostPort      = var.frontend_container_port
          protocol      = "tcp"
        }
      ]
    }
  ])
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  # Set the task role ARN if needed
  # task_role_arn = aws_iam_role.ecs_task_role.arn

  # Set the task execution role ARN if needed
  # execution_role_arn = aws_iam_role.ecs_execution_role.arn

  # Define the task volume if needed
  # volume {
  #   name = "my-volume"
  #   host_path = "/path/on/host"
  # }
}

# Define the ECS service for the frontend
resource "aws_ecs_service" "frontend" {
  name            = var.frontend_task_family
  cluster         = var.cluster_name
  task_definition = aws_ecs_task_definition.frontend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnets
    security_groups = var.security_group_ids
    assign_public_ip = true
  }
}
