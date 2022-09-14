data "aws_ami" "aws_optimized_ecs" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami*amazon-ecs-optimized"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["591542846629"] # AWS
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ecs" {
  key_name   = "key-${var.app_name}-${var.environment}"
  public_key = tls_private_key.example.public_key_openssh
}

resource "aws_launch_configuration" "ecs_config_launch_config_spot" {
  name_prefix                 = "ecs-cluster-spot"
  image_id                    = data.aws_ami.aws_optimized_ecs.id
  instance_type               = var.instance_type_spot
  spot_price                  = var.spot_bid_price
  associate_public_ip_address = true
  lifecycle {
    create_before_destroy = true
  }
  user_data = <<EOF
#!/bin/bash
echo ECS_CLUSTER=${var.cluster_name} >> /etc/ecs/ecs.config
EOF

  security_groups = [aws_security_group.ecs_sg.id]

  key_name             = aws_key_pair.ecs.key_name
  iam_instance_profile = aws_iam_instance_profile.ecs_agent.arn
}
