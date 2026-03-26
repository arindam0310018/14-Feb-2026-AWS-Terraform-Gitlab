output "vpc_id" {
  value       = aws_vpc.amvpc.id
}

output "subnet_id" {
  value       = aws_subnet.amsubnet.id
}

output "security_group_id" {
  value       = aws_security_group.amsg.id
}
