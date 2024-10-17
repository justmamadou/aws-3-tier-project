resource "aws_autoscaling_group" "webserver" {
  name = "webserver-autoscaling"
  max_size = 5
  min_size = 1
  launch_template {
    id = aws_launch_template.webserver.id
  }
  vpc_zone_identifier = [aws_subnet.public_zone1, aws_subnet.public_zone2]
  health_check_type         = "ELB"
  
}