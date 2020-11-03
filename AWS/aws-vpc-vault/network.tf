resource "aws_vpc" "vault" {
  cidr_block = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
  assign_generated_ipv6_cidr_block = "false"
  tags = {
    "Environment" = var.environment_tag
     Name = "vault_vpc"
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  vpc_id = aws_vpc.vault.id 
  cidr_block = var.secondary_cidr
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vault.id
  tags = {
    "Environment" = var.environment_tag
     Name = "vault_internet_gateway"
  }
}

data "aws_availability_zones" "all" {
  state = "available"
}

locals {
    availability_zones = data.aws_availability_zones.all.names
}

resource "aws_subnet" "private" {
  count = "${var.private_subnet_count}"
  vpc_id = aws_vpc.vault.id
  cidr_block = "${cidrsubnet(aws_vpc.vault.cidr_block,8,count.index)}"
  availability_zone = "${element(data.aws_availability_zones.all.names, count.index)}"
  map_public_ip_on_launch = "false"
  tags = {
    "Environment" = var.environment_tag
     Name = "Private-vault-subnet - ${element(data.aws_availability_zones.all.names, count.index)}"
  }
}

resource "aws_subnet" "public" {
  count = "${var.public_subnet_count}"
  vpc_id = aws_vpc.vault.id
  cidr_block = "${cidrsubnet(aws_vpc_ipv4_cidr_block_association.secondary_cidr.cidr_block,8,count.index)}"
  availability_zone = "${element(data.aws_availability_zones.all.names, count.index)}"
  map_public_ip_on_launch = "true"
  tags = {
    "Environment" = var.environment_tag
     Name = "Public-vault-subnet - ${element(data.aws_availability_zones.all.names, count.index)}"
  }
}




resource "aws_route_table" "rtb_private" {
  vpc_id = aws_vpc.vault.id

  tags = {
    "Environment" = var.environment_tag
     Name = "private_route_table"
  }
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vault.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Environment" = var.environment_tag
     Name = "public_route_table"
  }
}

resource "aws_route_table_association" "rta_subnet_public" {
  count          = "${var.public_subnet_count}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_route_table_association" "rta_subnet_private" {
  count          = "${var.private_subnet_count}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = aws_route_table.rtb_private.id
}


resource "aws_vpc_endpoint" "s3" {
  vpc_id = aws_vpc.vault.id
  service_name = "com.amazonaws.eu-west-2.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids       = [aws_route_table.rtb_private.id]

  tags = {
    "Environment" = var.environment_tag
     Name = "S3 Endpoint"
  }
}


resource "aws_vpc_endpoint" "kms" {
  vpc_id = aws_vpc.vault.id
  service_name = "com.amazonaws.eu-west-2.kms"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vault.id,
  ]

  tags = {
    "Environment" = var.environment_tag
     Name = "KMS Endpoint"
  }
}


resource "aws_vpc_endpoint_subnet_association" "private_kms_subnet" {
  count                = "${var.public_subnet_count}"
  vpc_endpoint_id      = aws_vpc_endpoint.kms.id
  subnet_id            = "${element(aws_subnet.private.*.id, count.index)}"

}

resource "aws_vpc_endpoint" "db" {
  vpc_id               = aws_vpc.vault.id
  service_name         = "com.amazonaws.eu-west-2.dynamodb"
  vpc_endpoint_type    = "Gateway"
  route_table_ids       = [aws_route_table.rtb_private.id]

  tags = {
    "Environment" = var.environment_tag
     Name = "DB Endpoint"
  }
}