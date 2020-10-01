variable "profile" {
    default = "terraform"
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
    default = null
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
    default = null
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
  default = "eu-west-1b"
}

variable "environment_tag" {
  description = "Environment tag"
  default = "test"
}

variable "app_name" {
    default = "rtx"
}

variable "runtime" {
    default = "python3.7"
}

variable "lambdafile" {
    default = null
}

variable "handler" {
  default = "handler"
}

variable "function_name" {
  default = "minimal_lambda_function"
}



