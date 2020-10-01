resource "digitalocean_record" "www" {
  domain = var.domain_name
  type   = "A"
  name   = "@"
  value  = digitalocean_droplet.freeipa.ipv4_address
}

resource "digitalocean_record" "wildcard" {
  domain = var.domain_name
  type   = "A"
  name   = "*"
  value  = digitalocean_droplet.freeipa.ipv4_address
}