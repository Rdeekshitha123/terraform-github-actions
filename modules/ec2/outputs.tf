output "instance_id" {
  value = aws_instance.my_ec2.id
}
output "allow_ssh_sg_id" {
  value = aws_security_group.allow_ssh.id
}
