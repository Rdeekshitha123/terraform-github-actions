output "alb_dns_name" {
  value = aws_lb.my_alb.dns_name
}
output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}
