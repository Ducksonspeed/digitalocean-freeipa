output "instance_ip" {
  value = concat(digitalocean_droplet.kubema.*.ipv4_address, digitalocean_droplet.kubework.*.ipv4_address)
}

resource "local_file" "ansible_inv_preconfig" {
  content = templatefile("templates/hosts.tmpl",
  {
  master-name = digitalocean_droplet.kubema.*.name,
  master-ip = digitalocean_droplet.kubema.*.ipv4_address,
  worker-name = digitalocean_droplet.kubework.*.name,
  worker-ip = digitalocean_droplet.kubework.*.ipv4_address
  }
  )
  filename = "./Kubeadm-ansible/hosts.ini"
}


resource "local_file" "vars-all" {
  content = templatefile("templates/vars.tmpl",
  {
  username = "${var.usertosetup}"
  master-ip = [digitalocean_droplet.kubema.*.ipv4_address]
  }
  )
  filename = "./kubeadm-ansible/group_vars/all.yml"
}

