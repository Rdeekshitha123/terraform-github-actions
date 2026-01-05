resource "aws_vpc" "my_vpc" {
  instance_tenancy     = "default"
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "main-gw"
  }
}

resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }
  tags = {
    Name = "main-public"
  }
}

resource "aws_route_table_association" "main-public-1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.main-public.id
}
resource "aws_route_table_association" "main-public-2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.main-public.id
}
