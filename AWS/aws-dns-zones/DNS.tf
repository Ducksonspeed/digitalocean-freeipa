resource "aws_route53_zone" "vault" {
  name = "vault.alexhayward.me"

  tags = {
    Environment = "prod"
  }
}

resource "aws_route53_record" "cert_valid" {
  zone_id = aws_route53_zone.vault.zone_id
  name    = "_b7223840e925fca24016464566a20f2e.vault.alexhayward.me."
  type    = "CNAME"
  ttl     = "300"
  records = ["_1ae56bae6de94bdabdf0fa6125b99437.zbkrxsrfvj.acm-validations.aws."]
}