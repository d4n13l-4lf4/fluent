terraform {
  cloud {
    # configured from env vars
    workspaces {}
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = "~> 1.7.5"
}

provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      ENVIRONMENT = var.stage
    }
  }
}