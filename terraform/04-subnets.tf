resource "aws_subnet" "private_zone1" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/19"
  availability_zone = local.az1

  tags = {
    "Name" = "${local.env}-private-${local.az1}"
  }
}

resource "aws_subnet" "private_zone2" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.32.0/19"
  availability_zone = local.az2

  tags = {
    "Name" = "${local.env}-private-${local.az2}"
  }
}

resource "aws_subnet" "public_zone1" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.64.0/19"
  availability_zone = local.az1
  map_public_ip_on_launch = true

  tags = {
    "Name"= "${local.env}-public-${local.az1}"
  }
}

resource "aws_subnet" "public_zone2" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.96.0/19"
  availability_zone = local.az2
  map_public_ip_on_launch = true

  tags = {
    "Name"= "${local.env}-public-${local.az2}"
  }
}