resource "digitalocean_firewall" "docker" {
    name = "docker-test-sec-group"
    
    droplet_ids = concat(digitalocean_droplet.dockerm.*.id, digitalocean_droplet.dockerw.*.id)


   inbound_rule {
    
    port_range  = 22
    protocol    = "tcp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

   inbound_rule {
    
    port_range  = 443
    protocol    = "tcp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    
    port_range  = 80
    protocol    = "tcp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol    = "tcp"
    port_range = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

   outbound_rule {
    protocol    = "udp"
    port_range = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

}


