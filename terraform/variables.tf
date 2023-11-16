variable "aws_region" {
  default = "us-west-2"
}

variable "backstage_ami_id" {
  description = "AMI ID for Backstage EC2 instance"
  default     = "ami-0f723dfedd862c077" # Replace a valid AMI ID
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "Key pair name"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
