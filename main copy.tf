terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0" # Optional but recommended in production
    }
  }
  backend "s3" {
    bucket = "class-magnus-amudi"
    key = "new/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "newvpc" {
   cidr_block = "10.0.0.0/24"

  tags = {
    Name = "trial-${random_string.random_suffix.result}"
    Team = "DevOps"
    Environment = "Prod"
    Division = "HR"
  }
}

resource "random_string" "random_suffix" {
  length  = 3
  special = false
  upper   = false
}

resource "aws_s3_bucket" "onebucket" {
   bucket = "mybucket-${random_string.random_suffix.result}"
   acl = "private"
   versioning {
      enabled = true
   }
   tags = {
     Name = "newbucket"
     Environment = "Test"
   }
}
