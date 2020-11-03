output "vm-name" {
    value = google_compute_instance.kube.*.name
}

output "vm-external-ip" {
    value = google_compute_instance.kube.*.network_interface.0.access_config.0.nat_ip
}

output "vm-internal-ip" {
    value = google_compute_instance.kube.*.network_interface.0.network_ip
}