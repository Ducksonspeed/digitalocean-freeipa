resource "aws_security_group" "freeipa" {
    name = "freeipa-security-group"
    description = "Allow HTTP, HTTPS, SSH, LDAP, LDAPS, kerberos, kpasswd"
    vpc_id = aws_vpc.ldap.id


   ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    description = "LDAP"
    from_port   = 389
    to_port     = 389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    description = "LDAPS"
    from_port   = 636
    to_port     = 636
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    description = "KERBEROS"
    from_port   = 88
    to_port     = 88
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "KERBEROS"
    from_port   = 88
    to_port     = 88
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    description = "KPASSWD"
    from_port   = 464 
    to_port     = 464 
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "KPASSWD"
    from_port   = 464
    to_port     = 464
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

 tags = {
    Name = "FreeIPA-rules"
    }
}