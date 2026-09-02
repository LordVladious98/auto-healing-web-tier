variable "aws_region" {
  description = "AWS region used for the deployment"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for naming and tagging"
  type        = string
  default     = "auto-healing-web-tier"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "assessment"
}