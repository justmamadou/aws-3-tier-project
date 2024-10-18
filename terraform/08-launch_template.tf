resource "aws_launch_template" "webserver" {
  name = "webserver-template"

  image_id = "ami-00385a401487aefa4"
  instance_type = "t2.micro"
  key_name = "webserver_key"
  user_data = filebase64("${path.module}/../apache-install.sh")
  vpc_security_group_ids = [ aws_security_group.webserver_sg.id ]

}

resource "aws_launch_template" "appserver" {
  name = "appserver-template"

  image_id = "ami-00385a401487aefa4"
  instance_type = "t2.micro"
  key_name = "webserver_key"
  user_data = filebase64("${path.module}/../mysql-install.sh")
  vpc_security_group_ids = [ aws_security_group.appserver_sg.id ]

}