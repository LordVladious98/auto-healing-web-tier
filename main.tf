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