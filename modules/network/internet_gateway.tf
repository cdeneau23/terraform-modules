resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "igw-${var.app_name}-${var.environment}"
    Environment = "${var.app_name}-${var.environment}"
  }
}
