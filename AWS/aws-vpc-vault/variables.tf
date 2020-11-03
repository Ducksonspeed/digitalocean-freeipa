variable "profile" {
    default = null
}

variable "aws_secret" {
    default = null
}

variable "region" {
    type = string
    description = "Amazon region"
    default = "eu-west-2"
}

variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default = "10.1.0.0/16"
}

variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}

variable "private_subnet_count" {
  default = "3"
}

variable "public_subnet_count" {
  default = "3"
}

variable "secondary_cidr" {
  default = "172.1.0.0/16"
}
