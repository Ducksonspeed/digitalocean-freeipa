output "instance_ip" {
  value = concat(digitalocean_droplet.dockerm.*.ipv4_address, digitalocean_droplet.dockerw.*.ipv4_address)
}


resource "local_file" "ansible_inv_preconfig" {
  content = templatefile("inventory.tmpl",
  {
  master-name = digitalocean_droplet.dockerm.*.name,
  master-ip = digitalocean_droplet.dockerm.*.ipv4_address,
  worker-name = digitalocean_droplet.dockerw.*.name,
  worker-ip = digitalocean_droplet.dockerw.*.ipv4_address
  }
  )
  filename = "inventory"
}



