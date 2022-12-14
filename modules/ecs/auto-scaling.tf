resource "aws_autoscaling_group" "ecs_cluster_spot" {
  name_prefix = "asg-spot-${var.cluster_name}-${var.app_name}-${var.environment}"
  termination_policies = [
    "OldestInstance"
  ]
  default_cooldown          = 30
  health_check_grace_period = 30
  max_size                  = var.max_spot
  min_size                  = var.min_spot
  desired_capacity          = var.min_spot

  launch_configuration = aws_launch_configuration.ecs_config_launch_config_spot.name

  lifecycle {
    create_before_destroy = true
  }
  vpc_zone_identifier = var.public_security_groups

  tags = [
    {
      key   = "Name"
      value = var.cluster_name,

      propagate_at_launch = true
    }
  ]
}
