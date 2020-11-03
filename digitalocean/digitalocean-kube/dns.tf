resource "digitalocean_record" "master" {
  count = var.instance_count_m
  domain = var.domain_name
  type   = "A"
  name   = "master-${count.index}"
  value  = element(digitalocean_droplet.kubema.*.ipv4_address, count.index)
}

resource "digitalocean_record" "worker" {
  count = var.instance_count_w
  domain = var.domain_name
  type   = "A"
  name   = "node-${count.index + 1}"
  value  = element(digitalocean_droplet.kubework.*.ipv4_address, count.index)
}
