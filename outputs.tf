output "vpc_id" {
  description = "ID of the VPC"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.network.public_subnet_ids
}

output "alb_dns_name" {
  description = "DNS name of the application load balancer"
  value       = module.load_balancer.alb_dns_name
}