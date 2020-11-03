variable "profile" {
    default = null
}

variable "aws_secret" {
    default = null
}

variable "publickeys" {
    type = string
    description = "public key"
    default = null
} 

variable "privatekey" {
    type = string
    description = "private key"
    default = null
}

variable "user" {
    type = string
    description = "user"
    default = "ubuntu"
}

variable "ami" {
    type = string
    description = "Machine image"
    default = "ami-082335b69bcfdb15b"
}

variable "instance_type" {
    type = string 
    description = "EC2 Instance type"
    default = "t2.nano"
}

variable "region" {
    type = string
    description = "Amazon region"
    default = "eu-west-2"
}

variable "sethostname" {
    type = string
    description = "hostname"
    default = "ipa.private"
}

variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default = "10.1.0.0/16"
}

variable "cidr_subnet" {
  description = "CIDR block for the subnet"
  default = "10.1.0.0/24"
}

variable "availability_zone" {
  description = "availability zone to create subnet"
  default = "eu-west-2b"
}

variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}




