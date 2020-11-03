output "vault-private-subnet" {
    value = aws_subnet.private.*.id
}

output "vault-public-subnet" {
    value = aws_subnet.public.*.id
}


