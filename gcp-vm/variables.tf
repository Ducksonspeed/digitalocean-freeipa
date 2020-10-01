variable "project" {
    default = null
}

variable "region" {
    default = "europe-west2"

}

variable "zone" {
    default = "europe-west2-a"

}  

variable "instance" {
    default = "f1-micro"
}

variable "image" {
    default = "null"

}

variable "public_subnet_cidr_1" {
    type = string

}

variable "app_name" {
  type = string
  description = "Application name"
}

# define application domain
variable "app_domain" {
  type = string
  description = "Application domain"
}

# define application environment
variable "app_env" {
  type = string
  description = "Application environment"
}

variable "instance_count" {
    default = 1
}

variable "script_path" {
    default = null
}

variable "private_key_path" {
    default = null
}

variable "username" {
    default = "ubuntu"
}

variable "script_path_build" {
    default = null
}