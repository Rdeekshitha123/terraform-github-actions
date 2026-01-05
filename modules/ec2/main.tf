resource "aws_instance" "my_ec2" {
  ami                  = "ami-00ca32bbc84273381"
  instance_type        = var.my_instance_type
  iam_instance_profile = var.instance_profile

  tags = {
    Name = "my-ec2"
  }
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  user_data              = <<-EOF
              #!/bin/bash
              
              
              sudo yum update -y
              sudo yum install -y nginx
              
              
              sudo systemctl enable nginx
              sudo systemctl start nginx

              
              echo "<h1> Hello from EC2 </h1>" | sudo tee /usr/share/nginx/html/index.html
              EOF


}

resource "aws_security_group" "allow_ssh" {
  vpc_id = var.vpc_id
  name   = "allow_ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}