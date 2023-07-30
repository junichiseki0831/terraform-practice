output "app_sg" {
    value = aws_security_group.app_sg.id
}

output "ssh_sg" {
    value = aws_security_group.ssh_sg.id
}