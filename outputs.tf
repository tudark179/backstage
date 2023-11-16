output "backstage_instance_ip" {
  value = aws_instance.backstage.public_ip
}