output "instance_ip" {
  value = digitalocean_droplet.freeipa.ipv4_address
}


resource "local_file" "ansible_inv" {
  content = templatefile("inventory.tmpl",
  {
  name = digitalocean_droplet.freeipa.name
  instance-ip = digitalocean_droplet.freeipa.ipv4_address
  username = "${var.username}"
  private-key = "${var.private_key_path}"
  }
  )
  filename = "inventory"
}

resource "local_file" "vars" {
  content = templatefile("vars.tmpl",
  {
  username = "${var.usertosetup}"
  domain = "${var.domain_name}"
  instance-name = digitalocean_droplet.freeipa.name
  instance-ip = digitalocean_droplet.freeipa.ipv4_address
  traefik_version = "${var.traefik_version}"
  globalhttps = "${var.globalhttps}"
  accesslogtraefik = "${var.accesslog}"
  acme_enable = "${var.acme_enable}"
  acme_email = "${var.acme_email}"
  acme_dns = "${var.acme_dns_wildcard}"
  acme_service_file_name = "${var.servicefile}"
  acme_service_file_src = "${var.servicefilesrc}"
  traefik_dashboard = "${var.traefik_dashboard_enable}"
  traefik_dashboard_subdomain = "${var.traefik_dashboard_subdomain}"
  traefik_dashboard_basicauth_enable = "${var.traefik_dashboard_basicauth_enable}"
  freeipa_subdomain = "${var.freeipa_subdomain}"
  ADMIN_PASSWD = "${var.freeipa_admin_passwd}"
  DS_PASSWD = "${var.freeipa_ds_passwd}"
  freeipa_compose = "${var.freeipa_compose_location}"
  portainer_subdomain = "${var.portainer_subdomain}"
  portainer_dir = "${var.portainer_dir}"
  }
  )
  filename = "ansible-freeipa/defaults/main.yml"
}



