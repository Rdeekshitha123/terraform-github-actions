data "aws_iam_policy" "s3_read_only" {
  arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2-s3-access-role-${terraform.workspace}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = data.aws_iam_policy.s3_read_only.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-s3-instance-profile-${terraform.workspace}"
  role = aws_iam_role.ec2_role.name
}
