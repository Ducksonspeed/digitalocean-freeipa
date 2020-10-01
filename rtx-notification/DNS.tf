data "aws_route53_zone" "aws" {
  name         = "aws.alexhayward.me."
  private_zone = false
}

resource "aws_route53_record" "rtx" {
  zone_id = data.aws_route53_zone.aws.zone_id
  name    = "rtx.${data.aws_route53_zone.aws.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.lb.public_ip]
}

