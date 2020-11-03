variable "keyname" {
    default = null
}

variable "instance_master" {
    default = "s-1vcpu-1gb"
}

variable "instance_worker" {
    default = "s-1vcpu-1gb"
}

variable "image" {
    default = "ubuntu-20-04-x64"

}

variable "region" {
    default = "lon1"

}

variable "domain_name" {
    default = null

}

variable "credentials" {
    default = null
}

variable "instance_count_w" {
    default = null
}

variable "instance_count_m" {
    default = null
}

variable "app_name" {
    default = null
}

 variable "usertosetup" {
     default = null
 }