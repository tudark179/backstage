resource "aws_vpc" "backstage_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "BackstageVPC"
  }
}

resource "aws_internet_gateway" "backstage_igw" {
  vpc_id = aws_vpc.backstage_vpc.id
  tags = {
    Name = "BackstageIGW"
  }
}

resource "aws_route_table" "backstage_rt" {
  vpc_id = aws_vpc.backstage_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.backstage_igw.id
  }
  tags = {
    Name = "BackstageRouteTable"
  }
}

resource "aws_subnet" "backstage" {
  vpc_id     = aws_vpc.backstage_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "BackstageSubnet"
  }
}

resource "aws_route_table_association" "backstage_rta" {
  subnet_id      = aws_subnet.backstage.id
  route_table_id = aws_route_table.backstage_rt.id
}
