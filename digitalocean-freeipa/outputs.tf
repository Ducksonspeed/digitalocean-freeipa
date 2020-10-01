output "public-ip" {
    value = digitalocean_droplet.freeipa.ipv4_address
}