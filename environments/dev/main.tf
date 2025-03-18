provider "aws" {
  region = var.region
}

module "vpc" {
  source             = "../../modules/vpc"
  env                = var.env
  region             = var.region
  vpc_cidr           = "10.0.0.0/16"
}

module "ecr" {
  source = "../../modules/ecr"
  env    = var.env
}

module "alb" {
  source           = "../../modules/alb"
  env              = var.env
  vpc_id           = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

module "ecs_fargate" {
  source                = "../../modules/fargate"
  env                   = var.env
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  alb_security_group_id = module.alb.alb_security_group_id
  target_group_arn      = module.alb.target_group_arn
  image_url             = "${module.ecr.repository_url}:latest"
  instance_count        = var.instance_count
}