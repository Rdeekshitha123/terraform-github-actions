resource "aws_s3_bucket" "devoncredentials001"{
bucket="devoncredentials-${terraform.workspace}-005"


force_destroy=true
}