resource "aws_security_group" "webserver_sg" {
  name        = "webserver_sg"
  description = "A Security Group for the web servers"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "webserver_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_webserver" {
  security_group_id = aws_security_group.webserver_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_webserver" {
  security_group_id = aws_security_group.webserver_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6_webserver" {
  security_group_id = aws_security_group.webserver_sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" 
}

resource "aws_security_group" "bastion_sg" {
  name        = "bastion_sg"
  description = "A Security Group for the database"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "bastion_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_bastion" {
  security_group_id = aws_security_group.bastion_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_bastion" {
  security_group_id = aws_security_group.bastion_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

resource "aws_security_group" "appserver_sg" {
  name        = "appserver_sg"
  description = "A Security Group for the app servers"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "appserver_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_from_bastion" {
  security_group_id = aws_security_group.appserver_sg.id
  referenced_security_group_id = aws_security_group.bastion_sg.id
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_icmp_from_bastion" {
  security_group_id = aws_security_group.appserver_sg.id
  referenced_security_group_id = aws_security_group.bastion_sg.id
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_traffic" {
  security_group_id = aws_security_group.appserver_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

resource "aws_security_group" "database_sg" {
  name        = "database_sg"
  description = "A Security Group for the database"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "database_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_mysql" {
  security_group_id = aws_security_group.database_sg.id
  referenced_security_group_id = aws_security_group.appserver_sg.id
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_traffic_db" {
  security_group_id = aws_security_group.database_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}