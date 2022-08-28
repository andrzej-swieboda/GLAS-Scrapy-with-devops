terraform {

  backend "s3" {
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {

  region  = "us-east-1"
    default_tags {
    tags = {
      Environment = "${var.app_env}"
    }
  }
}