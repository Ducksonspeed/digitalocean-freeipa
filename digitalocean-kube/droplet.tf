data "digitalocean_ssh_key" "ssh_key" {
  name = var.keyname
}

resource "random_id" "instance_id" {
  byte_length = 4
}

resource "digitalocean_droplet" "kubema" {
  image  = var.image
  name   = "${var.app_name}-m-${random_id.instance_id.hex}-${count.index}"
  count = "${var.instance_count_m}"
  region = var.region
  size   = var.instance_master
  ssh_keys = [
    data.digitalocean_ssh_key.ssh_key.id
  ]

}

resource "digitalocean_droplet" "kubework" {
  image  = var.image
  name   = "${var.app_name}-w-${random_id.instance_id.hex}-${count.index}"
  count = "${var.instance_count_w}"
  region = var.region
  size   = var.instance_worker
  ssh_keys = [
    data.digitalocean_ssh_key.ssh_key.id
  ]

}



