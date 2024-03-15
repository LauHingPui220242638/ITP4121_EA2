output "instance_ids" {
  value = aws_instance.instance[*].id
}

output "instance_public_ips" {
  value = aws_instance.instance[*].public_ip
}

output "private_ec2_sg_id" {
  value       = aws_security_group.private_ec2_sg.id
  description = "The ID of the private EC2 instances security group."
}
