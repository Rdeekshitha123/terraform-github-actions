output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "public_subnets" {
  value = [
    aws_subnet.public-subnet-1.id,
    aws_subnet.public-subnet-2.id
  ]
}

