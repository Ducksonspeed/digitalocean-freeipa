resource "aws_route53_zone" "private" {
  name = "ipa.private"

  vpc {
    vpc_id = aws_vpc.ldap.id
  }
}

resource "aws_route53_record" "record_txt_internal" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "_kerberos.${aws_route53_zone.private.name}"
  records = ["IPA.PRIVTE"]
  type    = "TXT"
  ttl     = "300"
}

resource "aws_route53_record" "record_srv1_internal" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "_kerberos-master._tcp.${aws_route53_zone.private.name}"
  records = ["0 100 88 ipa.private"]
  type    = "SRV"
  ttl     = "300"
}

resource "aws_route53_record" "record_srv2_internal" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "_kerberos._tcp.${aws_route53_zone.private.name}"
  records = ["0 100 88 ipa.private"]
  type    = "SRV"
  ttl     = "300"
}

resource "aws_route53_record" "record_srv3_internal" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "_kpasswd._tcp.${aws_route53_zone.private.name}"
  records = ["0 100 464 ipa.private"]
  type    = "SRV"
  ttl     = "300"
}

resource "aws_route53_record" "record_srv4_internal" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "_ldap._tcp.${aws_route53_zone.private.name}"
  records = ["0 100 389 ipa.private"]
  type    = "SRV"
  ttl     = "300"
}

resource "aws_route53_record" "record_srv5_internal" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "_kerberos-master._udp.${aws_route53_zone.private.name}"
  records = ["0 100 88 ipa.private"]
  type    = "SRV"
  ttl     = "300"
}

resource "aws_route53_record" "record_srv6_internal" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "_kerberos._udp.${aws_route53_zone.private.name}"
  records = ["0 100 88 ipa.private"]
  type    = "SRV"
  ttl     = "300"
}

resource "aws_route53_record" "record_srv7_internal" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "_kpasswd._udp.${aws_route53_zone.private.name}"
  records = ["0 100 464 ipa.private"]
  type    = "SRV"
  ttl     = "300"
}

resource "aws_route53_record" "record_srv8_internal" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "_ntp._udp.${aws_route53_zone.private.name}"
  records = ["0 100 88 ipa.private"]
  type    = "SRV"
  ttl     = "300"
}



data "aws_route53_zone" "aws" {
  name         = "aws.alexhayward.me."
  private_zone = false
}

resource "aws_route53_record" "ipa" {
  zone_id = data.aws_route53_zone.aws.zone_id
  name    = "ipa.${data.aws_route53_zone.aws.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.lb.public_ip]
}

resource "aws_route53_zone" "reverse" {
  name         = "[10.1.0.172].in-addr.arpa."

 vpc {
    vpc_id = aws_vpc.ldap.id
  }
}