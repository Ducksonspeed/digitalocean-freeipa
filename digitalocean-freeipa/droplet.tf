data "digitalocean_ssh_key" "ssh_key" {
  name = var.keyname
}

resource "digitalocean_droplet" "freeipa" {
  image  = var.image
  name   = data.external.droplet_name.result.name
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


  provisioner "local-exec" {
    command = "echo '[All]\n${digitalocean_droplet.freeipa.name} ansible_host=${digitalocean_droplet.freeipa.ipv4_address} ansible_ssh_user=${var.username} ansible_ssh_private_key_file=${var.private_key_path} ansible_python_interpreter=/usr/bin/python' > inventory"
  }

  provisioner "local-exec" {
    command = "echo 'current_hostname: ${digitalocean_droplet.freeipa.name}\npublic_ip: ${digitalocean_droplet.freeipa.ipv4_address}\n '  > vars/ans-var.yml"
  }


  provisioner "remote-exec" {
    inline = ["echo 'Ansible remote-exec provision'"]

    connection {
        type = "ssh"
        user = var.username
        host = digitalocean_droplet.freeipa.ipv4_address
        private_key = file(var.private_key_path)
    }
}

  provisioner "local-exec" {
    command = "ansible-playbook -i inventory playbook.yml -v "
  } 

}


