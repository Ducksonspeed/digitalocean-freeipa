provider "digitalocean" {
  token = file(var.credentials)
}