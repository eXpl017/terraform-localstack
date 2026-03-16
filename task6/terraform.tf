terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket                      = "terraform-remote-state"
    key                         = "task6/terraform.tfstate"
    region                      = "us-east-1"
    use_lockfile                = true
    profile                     = "localstack"
    use_path_style              = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    endpoints = {
      s3 = "http://s3.localhost.localstack.cloud:4566"
    }
  }
}
