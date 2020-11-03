# data "google_dns_managed_zone" "main" {
#   name = "alexhayward"
# }


# resource "google_dns_record_set" "main" {
#   managed_zone = data.google_dns_managed_zone.main.name
#   count = "${var.instance_count}"
#   name    = "kube0${count.index}.${data.google_dns_managed_zone.main.dns_name}"
#   type    = "A"
#   ttl     = 300

  
#   rrdatas = "${element(google_compute_instance.kube.*.network_interface[0].access_config[0].nat_ip, count.index)}"
# }



