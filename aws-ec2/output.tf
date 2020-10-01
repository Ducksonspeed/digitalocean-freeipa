output "instance_ips" {
  value = ["${aws_instance.freeipa.*.public_ip}"]
}
output "instance_ip_private" {
  value = ["${aws_instance.freeipa.*.private_ip}"]
}
