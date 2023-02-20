provider "aws" {
  region = var.region
}

resource "aws_ecs_task_definition" "database_task" {
  family                   = var.database_task_family
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.database_cpu
  memory                   = var.database_memory

  container_definitions = jsonencode([
    {
      name      = var.database_container_name
      image     = var.database_image
      portMappings = [
        {
          containerPort = var.database_container_port
          hostPort      = var.database_container_port
        }
      ],
      environment = [
        {
          name  = "POSTGRES_USER"
          value = var.database_username
        },
        {
          name  = "POSTGRES_PASSWORD"
          value = var.database_password
        },
        {
          name  = "POSTGRES_DB"
          value = var.database_name
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "database_service" {
  name            = var.database_service_name
  cluster         = var.cluster_name
  task_definition = aws_ecs_task_definition.database_task.arn
  desired_count   = var.database_desired_count

  network_configuration {
    security_groups = [aws_security_group.database_sg.id]
    subnets         = var.subnets
    assign_public_ip = true
  }
}

resource "aws_security_group" "database_sg" {
  name_prefix = "database_sg_"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.database_container_port
    to_port     = var.database_container_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
