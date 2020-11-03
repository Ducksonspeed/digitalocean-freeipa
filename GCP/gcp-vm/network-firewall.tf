resource "google_compute_firewall" "allow-http" {
  name = "${var.app_name}-fw-allow-http"
  network = "${google_compute_network.vpc.name}"
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
    allow {
    protocol = "icmp"
    }   
  target_tags = ["http"]
}

# allow https traffic
resource "google_compute_firewall" "allow-https" {
  name = "${var.app_name}-fw-allow-https"
  network = "${google_compute_network.vpc.name}"
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

    allow {
    protocol = "icmp"
    }
  target_tags = ["https"]
}

# allow ssh traffic
resource "google_compute_firewall" "allow-ssh" {
  name = "${var.app_name}-fw-allow-ssh"
  network = "${google_compute_network.vpc.name}"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["ssh"]
}

resource "google_compute_firewall" "allow_kube" {
    name = "${var.app_name}-fw-allow-kube"
    network = "${google_compute_network.vpc.name}"
    allow {
      protocol =  "tcp"
      ports = ["6443"]
    }

    allow {
    protocol = "icmp"
    }
    target_tags = ["kube"]
}
