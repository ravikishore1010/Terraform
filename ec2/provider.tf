terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }



    backend "s3" {
    bucket = "pb4rk"
    key    = "one"
    region = "ap-south-1"
    dynamodb_table = "table-timing"
  }
}


# Configure the AWS Provider
provider "aws" {
 region = "ap-south-1"
 
}