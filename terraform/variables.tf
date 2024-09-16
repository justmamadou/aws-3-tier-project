variable "vpc_name" {
  description = "vpc name"
  default = "my-vpc"
  type = string
}

variable "cidr" {
  description = "cidr"
  type = string
  default = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability zone"
  type = list(string)
  default = ["eu-west-1a", "eu-west-1b"]
}

variable "private_subnets" {
  description = "private subnets"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "database_subnets" {
  description = "database subnets"
  type = list(string)
  default = [ "10.0.3.0/24", "10.0.4.0/24"]
}

variable "public_subnets" {
  description = "public subnets"
  type = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "enable_nat_gateway" {
  description = "enable nat gateway"
  type = bool
  default = true
}