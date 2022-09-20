terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.4.0"
      region = "us-east-1"
    }
  }
  required_version = ">= 1.1.0"
}
