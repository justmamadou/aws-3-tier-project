resource "aws_autoscaling_group" "webserver" {
  name = "webserver-autoscaling"
  max_size = 5
  min_size = 1
  launch_template {
    id = aws_launch_template.webserver.id
  }
  vpc_zone_identifier = [aws_subnet.public_zone1.id, aws_subnet.public_zone2.id]
  health_check_type         = "ELB"
  target_group_arns = [aws_lb_target_group.web_tg.arn]
  
}

# Politique de scaling basée sur l'utilisation du CPU
resource "aws_autoscaling_policy" "web_cpu_scaling" {
  name                   = "cpu-scaling-policy"
  adjustment_type         = "ChangeInCapacity"
  autoscaling_group_name  = aws_autoscaling_group.webserver.name

  policy_type             = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 90.0  # Scalera si l'utilisation CPU dépasse 50%
  }
}

resource "aws_autoscaling_group" "appserver" {
  name = "appserver-autoscaling"
  max_size = 5
  min_size = 1
  launch_template {
    id = aws_launch_template.appserver.id
  }
  vpc_zone_identifier = [aws_subnet.private_zone1.id, aws_subnet.private_zone2.id]
  health_check_type         = "ELB"
  target_group_arns = [aws_lb_target_group.app_tg.arn]
  
}

# Politique de scaling basée sur l'utilisation du CPU
resource "aws_autoscaling_policy" "app_cpu_scaling" {
  name                   = "cpu-scaling-policy"
  adjustment_type         = "ChangeInCapacity"
  autoscaling_group_name  = aws_autoscaling_group.appserver.name

  policy_type             = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 90.0  # Scalera si l'utilisation CPU dépasse 50%
  }
}

