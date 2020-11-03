resource "aws_security_group" "vault" {
    name = "Vault-security-group"
    description = "Allow SSH, & Vault"
    vpc_id = aws_vpc.vault.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

 tags = {
    Name = "Vault-rules"
    }
}