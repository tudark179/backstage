resource "aws_security_group" "backstage_sg" {
  name        = "backstage_sg"
  description = "Security group for Backstage instance"
  vpc_id      = aws_vpc.backstage_vpc.id
}

resource "aws_iam_role" "backstage_role" {
  name = "backstage_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
      },
    ],
  })
}
