terraform {
  required_version = "~> 1.5.7"

  backend "s3" {
    bucket = "buckettechdocs"
    key    = "tf-state.json"
    region = "ap-southeast-1"
    workspace_key_prefix = "environment"
  }  

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.44.0"
    }
  }
}
