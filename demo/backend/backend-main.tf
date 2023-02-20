provider "aws" {
  region = var.region
}

resource "aws_ecs_task_definition" "backend_task" {
  family                   = var.backend_task_family
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.backend_cpu
  memory                   = var.backend_memory

  container_definitions = jsonencode([
    {
      name      = var.backend_container_name
      image     = var.backend_image
      portMappings = [
        {
          containerPort = var.backend_container_port
          hostPort      = var.backend_container_port
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "backend_service" {
  name            = var.backend_service_name
  cluster         = var.cluster_name
  task_definition = aws_ecs_task_definition.backend_task.arn
  desired_count   = var.backend_desired_count

  load_balancer {
    target_group_arn = aws_lb_target_group.backend_target_group.arn
    container_name   = var.backend_container_name
    container_port   = var.backend_container_port
  }

  network_configuration {
    security_groups = [aws_security_group.backend_sg.id]
    subnets         = var.subnets
    assign_public_ip = true
  }
}

resource "aws_lb_target_group" "backend_target_group" {
  name     = var.backend_target_group_name
  port     = var.backend_container_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = var.backend_health_check_path
  }
}

resource "aws_security_group" "backend_sg" {
  name_prefix = "backend_sg_"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.backend_container_port
    to_port     = var.backend_container_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
