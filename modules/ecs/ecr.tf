resource "aws_ecr_repository" "nginx" {
  name                 = "ecr-${var.app_name}-${var.environment}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
