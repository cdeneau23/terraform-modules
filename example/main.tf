terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

module "state" {
  source = "../modules/state"
  app_name = "two-dogs-ecs-example"
  key_name = "alias/ecs-example"
  region = var.region
}

module "network" {
  source = "../modules/network"
  region = var.region
  app_name = "two-dogs-ecs-example"
  environment = "dev"
}

module "cluster" {
  depends_on = [
    module.network
  ]
  source = "../modules/ecs"
  cluster_name = "two-dogs-ecs-example-cluster"
  app_name = "two-dogs-ecs-example"
  environment = "dev"
  vpc_id = module.network.vpc_id
  public_security_groups = module.network.public_subnets_id
}

terraform {
 backend "s3" {
   bucket         = "state-two-dogs-ecs-example"
   key            = "state/terraform.tfstate"
   region         = "us-east-1"
   encrypt        = true
   kms_key_id     = "alias/ecs-example"
   dynamodb_table = "terraform-state-two-dogs-ecs-example"
 }
}