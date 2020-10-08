resource "digitalocean_record" "root" {
  count = var.instance_count_m
  domain = var.domain_name
  type   = "A"
  name   = "@"
  value  = element(digitalocean_droplet.dockerm.*.ipv4_address, count.index)
}

resource "digitalocean_record" "wild" {
  count = var.instance_count_m
  domain = var.domain_name
  type   = "A"
  name   = "*"
  value  = element(digitalocean_droplet.dockerm.*.ipv4_address, count.index)
}

resource "digitalocean_record" "worker" {
  count = var.instance_count_w
  domain = var.domain_name
  type   = "A"
  name   = "${var.app_name}-worker-${count.index + 1}"
  value  = element(digitalocean_droplet.dockerw.*.ipv4_address, count.index)
}
