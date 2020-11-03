resource "digitalocean_firewall" "freeipa" {
    name = "freeipa-security-group"
    
    droplet_ids = [digitalocean_droplet.freeipa.id]


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

   inbound_rule {
    
    port_range  = 389
    protocol    = "tcp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

   inbound_rule {
    
    port_range  = 636
    protocol    = "tcp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

   inbound_rule {
    
    port_range  = 88
    protocol    = "tcp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    
    port_range  = 88
    protocol    = "udp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

   inbound_rule {
    
    port_range  = 464 
    protocol    = "tcp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    
    port_range  = 464
    protocol    = "udp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

    inbound_rule {
    
    port_range  = 53
    protocol    = "udp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

    inbound_rule {
    
    port_range  = 53
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