resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "task_definition" {
  family                   = "service-${var.app_name}-${var.environment}"
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048

  container_definitions = <<DEFINITION
[
  {
    "image": "984964432631.dkr.ecr.us-east-1.amazonaws.com/ecr-two-dogs-ecs-example-dev:latest",
    "cpu": 1024,
    "memory": 2048,
    "name": "service-${var.app_name}-${var.environment}",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": 3000,
        "hostPort": 3000
      }
    ]
  }
]
DEFINITION

}

resource "aws_ecs_service" "service" {
  name            = "service-${var.app_name}-${var.environment}"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 2


  network_configuration {
    security_groups = [aws_security_group.ecs_sg.id]
    subnets         = var.public_security_groups
  }
}