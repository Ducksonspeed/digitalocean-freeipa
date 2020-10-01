output "instance_ips" {
  value = ["${aws_instance.rtx.*.public_ip}"]
}


resource "local_file" "ansible_inv" {
  content = templatefile("inventory.tmpl",
  {
  instance-name = "${lookup(aws_instance.rtx.tags, "Name")}"
  instance-ip = aws_eip.lb.public_ip
  }
  )
  filename = "inventory"
}