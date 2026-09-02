module "network" {
  source = "./modules/network"

  project_name = var.project_name
  environment  = var.environment
}

module "load_balancer" {
  source = "./modules/load-balancer"

  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
}

module "web_tier" {
  source = "./modules/web-tier"

  project_name      = var.project_name
  environment       = var.environment
  subnet_ids        = module.network.public_subnet_ids
  security_group_id = module.load_balancer.web_security_group_id
  target_group_arn  = module.load_balancer.target_group_arn
}