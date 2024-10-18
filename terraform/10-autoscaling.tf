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