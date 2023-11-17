# General
project = "backstage"
default_region = "ap-southeast-1"
vpc_cidr_block = "172.31.0.0/16"
public_subnets = {
  "ap-southeast-1a" = "172.31.0.0/20",
  "ap-southeast-1b" = "172.31.16.0/20"
}
