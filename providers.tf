provider "aws" {
  region = var.aws_region

  skip_credentials_validation = var.local_mode
  skip_metadata_api_check     = var.local_mode
  skip_requesting_account_id  = var.local_mode

  endpoints {
    ec2         = var.local_mode ? var.local_endpoint : null
    autoscaling = var.local_mode ? var.local_endpoint : null
    elbv2       = var.local_mode ? var.local_endpoint : null
    iam         = var.local_mode ? var.local_endpoint : null
    sts         = var.local_mode ? var.local_endpoint : null
  }
}