provider "aws" {
    profile = var.profile
    shared_credentials_file = file(var.aws_secret)
    region = var.region
}


terraform {
  backend "s3" {
    encrypt = true
    # cannot contain interpolations
    # bucket = "${aws_s3_bucket.terraform-state-s3-alex-personal-infra.bucket}"
    bucket = "terraform-state-s3-alex-personal-infra"
    # region = "${aws_s3_bucket.terraform-state-s3-alex-personal-infra.region}"
    region = "eu-west-2"
    # dynamodb_table = "alexinf-iac-terraform-state-lock-dynamo"
    key = "terraform-state-aws-ec2-basic/terraform.tfstate"
  }
}

resource "aws_key_pair" "freeipa" {
    key_name = "freeipa"
    public_key = file("${var.publickeys}")
}

resource "aws_instance" "freeipa" {
    key_name = aws_key_pair.freeipa.key_name
    ami = "${var.ami}"
    instance_type = "${var.instance_type}"
    vpc_security_group_ids = [ aws_security_group.freeipa.id ]
    subnet_id = aws_subnet.subnet_public.id
    associate_public_ip_address = true

    provisioner "remote-exec" {
       inline = ["sudo hostnamectl set-hostname ${var.sethostname}"]

    connection {
        type = "ssh"
        user = "${var.user}"
        private_key = file("${var.privatekey}")
        host = self.public_ip
    }
}

    root_block_device {
        volume_type = "gp2"
        volume_size = 30
        encrypted = true
 }
 

    credit_specification {
        cpu_credits = "standard"
  }


    tags = {
        Name = "freeipa-EC2"
        Environment = "dev"
    }

    volume_tags = {
        Name = "freeipa"
    }

 } 




  





