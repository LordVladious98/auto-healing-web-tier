variable "project_name" {
  description = "Project name used for naming and tagging"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs used by the Auto Scaling Group"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID attached to web instances"
  type        = string
}

variable "target_group_arn" {
  description = "Target group ARN used by the Auto Scaling Group"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "min_size" {
  description = "Minimum number of web instances"
  type        = number
  default     = 2
}

variable "desired_capacity" {
  description = "Desired number of web instances"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of web instances"
  type        = number
  default     = 3
}