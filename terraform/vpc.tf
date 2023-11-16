resource "aws_vpc" "backstage_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "BackstageVPC"
  }
}

resource "aws_subnet" "backstage" {
  vpc_id     = aws_vpc.backstage_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "BackstageSubnet"
  }
}