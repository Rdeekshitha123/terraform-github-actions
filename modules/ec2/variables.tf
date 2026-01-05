variable "subnet_id" {}
variable "my_instance_type" {
  default = "t3.micro"
}
variable "vpc_id" {}
variable "alb_sg_id" {}

variable "instance_profile" {}
