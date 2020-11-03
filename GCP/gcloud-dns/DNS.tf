data "google_dns_managed_zone" "main" {
  name = "alexhayward"
}

resource "google_dns_record_set" "kube-do" {
  managed_zone = data.google_dns_managed_zone.main.name
  name    = "kube.${data.google_dns_managed_zone.main.dns_name}"
  type    = "NS"
  ttl     = 1800

  rrdatas = ["ns1.digitalocean.com.", "ns2.digitalocean.com.","ns3.digitalocean.com." ]
  
}

resource "google_dns_record_set" "dev-digitalocean" {
  managed_zone = data.google_dns_managed_zone.main.name
  name    = "dev.${data.google_dns_managed_zone.main.dns_name}"
  type    = "NS"
  ttl     = 1800

  rrdatas = ["ns1.digitalocean.com.", "ns2.digitalocean.com.","ns3.digitalocean.com." ]
  
}

resource "google_dns_record_set" "vault-aws" {
  managed_zone = data.google_dns_managed_zone.main.name
  name    = "vault.${data.google_dns_managed_zone.main.dns_name}"
  type    = "NS"
  ttl     = 1800

  rrdatas = ["ns-1371.awsdns-43.org.", "ns-1566.awsdns-03.co.uk.","ns-712.awsdns-25.net.", "ns-38.awsdns-04.com." ]
  
}





