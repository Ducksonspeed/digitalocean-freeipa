data "digitalocean_ssh_key" "ssh_key" {
  name = var.keyname
}

resource "random_id" "instance_id" {
  byte_length = 4
}

resource "digitalocean_droplet" "freeipa" {
  image  = var.image
  name   = "${var.app_name}-${random_id.instance_id.hex}"
  region = var.region
  size   = var.instance
  ssh_keys = [
    data.digitalocean_ssh_key.ssh_key.id
  ]

}

resource "null_resource" "ansible-provision" {
  depends_on = [
    digitalocean_droplet.freeipa,
  ]


  provisioner "remote-exec" {
    inline = ["dnf install -y python3"]

    connection {
        type = "ssh"
        user = var.username
        host = digitalocean_droplet.freeipa.ipv4_address
        private_key = file(var.private_key_path)
    }
}


  provisioner "local-exec" {
    command = "ansible-playbook ansible-freeipa/main.yml -i inventory -vv"
  }
}



