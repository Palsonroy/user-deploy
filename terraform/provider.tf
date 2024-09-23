terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0" # AWS provider version, not terraform version
    }
  }

  backend "s3" {
    bucket         = "daws66s-state-development"
    key            = "user"
    region         = "us-east-1"
    dynamodb_table = "daws66s-locking-development"
  }
}

provider "aws" {
  region = "us-east-1"
}