resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "vpc-${var.app_name}-${var.environment}"
    Environment = "${var.app_name}-${var.environment}"
  }
}
