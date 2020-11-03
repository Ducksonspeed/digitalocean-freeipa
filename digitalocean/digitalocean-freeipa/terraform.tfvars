# DigitalOcean vars
region = "lon1"
instance = "s-1vcpu-2gb"
image = "72400051"
keyname = "leaseweb"
domain_name = "ipa.alexhayward.me"
private_key_path = "~/.ssh/leaseweb"
username = "root"
credentials = "secrets/credentials.env"
app_name = "ipa"

## Ansible Vars

## System
usertosetup = "alex"

## Traefik 
servicefilesrc = "../secrets/credentials.env"
servicefile = "credentials.env"
acme_dns_wildcard = "digitalocean"
acme_email = "admin@alexhayward.me"
acme_enable = "true"
accesslog = "false"
globalhttps = "true"
traefik_version = "2.2"
traefik_dashboard_enable = "true"
traefik_dashboard_subdomain = "dash"
traefik_dashboard_basicauth_enable = "false"

## Freeipa
freeipa_subdomain = "admin"
freeipa_admin_passwd = "test1234"
freeipa_ds_passwd = "test1234"
freeipa_compose_location = "/home/{{ user }}/freeipa"

## Portainer

portainer_subdomain = "portainer"
portainer_dir = "/home/{{ user }}/portainer"