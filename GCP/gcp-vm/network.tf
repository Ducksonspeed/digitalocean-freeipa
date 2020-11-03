 resource "google_compute_network" "vpc" {
    name = "${var.app_name}-${var.app_env}-vpc"
    auto_create_subnetworks = "false"
    routing_mode = "GLOBAL"
}

resource "google_compute_subnetwork" "public_subnet_1" {
  name = "${var.app_name}-${var.app_env}-public-subnet-1"
  ip_cidr_range = var.public_subnet_cidr_1
  network = google_compute_network.vpc.name
  region = var.region
}

resource "google_compute_address" "staticip" {
    name = "ip"
}
