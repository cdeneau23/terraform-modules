variable "environment" {
  type        = string
  description = "The Deployment environment"
}

variable "app_name" {
  type        = string
  description = "The app name"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block of the vpc"
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  type        = list(string)
  description = "The CIDR block for the public subnet"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "private_subnets_cidr" {
  type        = list(string)
  description = "The CIDR block for the private subnet"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "region" {
  type        = string
  description = "The region to launch the bastion host"
  default     = "us-east-1"
}

variable "availability_zones" {
  type        = list(string)
  description = "The az that the resources will be launched"
  default     = ["us-east-1a", "us-east-1b"]
}
