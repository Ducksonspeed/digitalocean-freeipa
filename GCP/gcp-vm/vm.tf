resource "random_id" "instance_id" {
  byte_length = 4
}


resource "google_compute_instance" "kube" {
    name = "${var.app_name}-vm-${random_id.instance_id.hex}-${count.index}"
    zone = var.zone
    count  = "${var.instance_count}"
    machine_type = var.instance
    hostname = "${var.app_name}vm-${random_id.instance_id.hex}.${var.app_domain}-${count.index}"
    tags = ["ssh","http"]

    boot_disk  {
        initialize_params {
            image = var.image
        }
    }

    network_interface  {
        network = google_compute_network.vpc.name
        subnetwork = google_compute_subnetwork.public_subnet_1.name
        access_config { 
            nat_ip = google_compute_address.staticip.address
        }
    }

    metadata = {
		ssh-keys = "ubuntu:${file("~/.ssh/leaseweb.pub")}"
	}

  provisioner "file" {
    source = "~/.ssh/leaseweb"
    destination = "/home/ubuntu/.ssh/leaseweb"

      connection {
        type = "ssh"
        host = google_compute_address.staticip.address
        user = var.username
        private_key = file(var.private_key_path)
    }
  }

    provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/ubuntu.ssh/leaseweb",
    ]
    

    connection {
      type        = "ssh"
      host        = google_compute_address.staticip.address
      user        = var.username
      private_key = file(var.private_key_path)
    }
  }

  provisioner "remote-exec" {
    script = var.script_path

    connection {
      type        = "ssh"
      host        = google_compute_address.staticip.address
      user        = var.username
      private_key = file(var.private_key_path)
    }
  }


}