resource "digitalocean_firewall" "kube" {
    name = "kube-security-group"
    
    droplet_ids = concat(digitalocean_droplet.kubema.*.id, digitalocean_droplet.kubework.*.id)


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

resource "digitalocean_firewall" "kubema" {
    name = "kube-master-security-group"
    
    droplet_ids = digitalocean_droplet.kubema.*.id


   inbound_rule {
    
    port_range  = 6443
    protocol    = "tcp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

   inbound_rule {
    
    port_range  = "2379-2380"
    protocol    = "tcp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

   inbound_rule {
    
    port_range  = "10250-10253"
    protocol    = "tcp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_firewall" "kubework" {
    name = "kube-workers-security-group"
    
    droplet_ids = digitalocean_droplet.kubework.*.id


   inbound_rule {
    
    port_range  = 10250
    protocol    = "tcp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

    inbound_rule {
    
    port_range  = "30000-32767"
    protocol    = "tcp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
}

