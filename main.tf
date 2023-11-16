provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "backstage" {
  ami           = var.backstage_ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.backstage.id

  tags = {
    Name = "BackstageInstance"
  }
}