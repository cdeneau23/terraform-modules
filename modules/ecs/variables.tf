variable "environment" {
  type        = string
  description = "The Deployment environment"
}

variable "app_name" {
  type        = string
  description = "The app name"
}

variable "vpc_id" {
  type        = string
  description = "The VPC Id for the network"
}

variable "instance_type_spot" {
  default = "t3a.medium"
  type    = string
}

variable "spot_bid_price" {
  default     = "0.0175"
  description = "How much you are willing to pay as an hourly rate for an EC2 instance, in USD"
}

variable "cluster_name" {
  default     = "ecs_terraform_ec2"
  type        = string
  description = "the name of an ECS cluster"
}

variable "min_spot" {
  default     = "2"
  description = "The minimum EC2 spot instances to be available"
}

variable "max_spot" {
  default     = "5"
  description = "The maximum EC2 spot instances that can be launched at peak time"
}

variable "public_security_groups" {
  type        = list(string)
  description = "Public security group ids"
}
