locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_launch_template" "web" {
  name_prefix   = "${var.project_name}-${var.environment}-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  vpc_security_group_ids = [var.security_group_id]

  user_data = base64encode(file("${path.root}/user-data/nginx.sh"))

  tag_specifications {
    resource_type = "instance"

    tags = merge(local.common_tags, {
      Name = "${var.project_name}-${var.environment}-web"
    })
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-lt"
  })
}

resource "aws_autoscaling_group" "web" {
  name                = "${var.project_name}-${var.environment}-asg"
  min_size            = var.min_size
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  vpc_zone_identifier = var.subnet_ids

  target_group_arns = [var.target_group_arn]

  health_check_type         = "ELB"
  health_check_grace_period = 60



  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  tag {
    key                 = "Project"
    value               = var.project_name
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }

  tag {
    key                 = "ManagedBy"
    value               = "terraform"
    propagate_at_launch = true
  }
}