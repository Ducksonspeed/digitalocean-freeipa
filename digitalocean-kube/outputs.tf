output "instance_ip" {
  value = concat(digitalocean_droplet.kubema.*.ipv4_address, digitalocean_droplet.kubework.*.ipv4_address)
}


resource "local_file" "ansible_inv" {
  content = templatefile("host.tmpl",
  {
  master-name = digitalocean_droplet.kubema.*.name,
  master-ip = digitalocean_droplet.kubema.*.ipv4_address,
  worker-name = digitalocean_droplet.kubework.*.name,
  worker-ip = digitalocean_droplet.kubework.*.ipv4_address
  }
  )
  filename = "kube/kubeadm-ansible-master/hosts.ini"
}

resource "local_file" "ansible_inv_preconfig" {
  content = templatefile("inventory.tmpl",
  {
  master-name = digitalocean_droplet.kubema.*.name,
  master-ip = digitalocean_droplet.kubema.*.ipv4_address,
  worker-name = digitalocean_droplet.kubework.*.name,
  worker-ip = digitalocean_droplet.kubework.*.ipv4_address
  }
  )
  filename = "inventory"
}



