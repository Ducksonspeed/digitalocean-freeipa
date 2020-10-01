resource "aws_vpc" "ldap" {
  cidr_block = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
  assign_generated_ipv6_cidr_block = "true"
  tags = {
    "Environment" = var.environment_tag
     Name = "ldap_vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ldap.id
  tags = {
    "Environment" = var.environment_tag
     Name = "ldap_gateway"
  }
}

resource "aws_subnet" "subnet_public" {
  vpc_id = aws_vpc.ldap.id
  cidr_block = var.cidr_subnet
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zone
  tags = {
    "Environment" = var.environment_tag
     Name = "ldap_subnet"
  }
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.ldap.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Environment" = var.environment_tag
  }
}

resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_eip" "lb" {
  instance = aws_instance.freeipa.id
  vpc = true
  depends_on = [aws_internet_gateway.igw]
}