output "instance_ids" {
  value = aws_instance.am-win-ec2instance[*].id
}

output "private_ips" {
  value = aws_instance.am-win-ec2instance[*].private_ip
}
