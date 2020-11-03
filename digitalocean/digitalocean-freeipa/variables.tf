variable "keyname" {
    default = null
}

variable "instance" {
    default = "s-1vcpu-1gb"
}

variable "image" {
    default = "ubuntu-18-04-x64"

}

variable "region" {
    default = "lon1"

}

variable "app_name" {
    default = null
}

variable "domain_name" {
    default = null

}

variable "token" {
    default = null
}

variable "private_key_path" {
    default = null
}

variable "username" {
    default = "root"
}

variable "credentials" {
    default = null
}

 variable "usertosetup" {
     default = null
 }

 variable "servicefilesrc" {
     default = null
 }

 variable "servicefile" {
     default = null
 }

 variable "acme_dns_wildcard" {
     default = null
 }

 variable "acme_email" {
     default = null
 }

 variable "acme_enable" {
     default = null
 }
 
 variable "traefik_dashboard_basicauth_enable" {
     default = null
 }
 
 variable "accesslog" {
     default = null
 }
 
 variable "globalhttps" {
     default = null
 }

 variable "traefik_version" {
     default = null
 }

 variable "traefik_dashboard_enable" {
     default = null
 }

 variable "traefik_dashboard_subdomain" {
     default = null
 }

 variable "freeipa_subdomain" {
     default = null
 }

  variable "freeipa_admin_passwd" {
     default = null
 }

  variable "freeipa_ds_passwd" {
     default = null
 }

  variable "freeipa_compose_location" {
     default = null
 }

  variable "portainer_subdomain" {
     default = null
 }

variable "portainer_dir" {
    default = null
}