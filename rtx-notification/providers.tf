provider "aws" {
    profile = var.profile
    shared_credentials_file = file(var.aws_secret)
    region = var.region
}

resource "aws_key_pair" "rtx" {
    key_name = "rtx"
    public_key = file("${var.publickeys}")
}

resource "random_id" "instance_id" {
  byte_length = 4
}

resource "aws_instance" "rtx" {
    key_name = aws_key_pair.rtx.key_name
    ami = "${var.ami}"
    instance_type = "${var.instance_type}"
    vpc_security_group_ids = [ aws_security_group.rtx.id ]
    subnet_id = aws_subnet.subnet_public.id
    associate_public_ip_address = true

    root_block_device {
        volume_type = "gp2"
        volume_size = 30
        encrypted = true
 }
 

    credit_specification {
        cpu_credits = "standard"
  }


    tags = {
        Name = "${var.app_name}-ec2-${random_id.instance_id.hex}"
        Environment = "dev"
    }

    volume_tags = {
        Name = "rtx"
    }

 } 




  





