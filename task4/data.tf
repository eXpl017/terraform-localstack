data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket                      = "terraform-remote-state"
    key                         = "task1/terraform.tfstate"
    region                      = "us-east-1"
    profile                     = "localstack"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    endpoints = {
      s3 = "http://s3.localhost.localstack.cloud:4566"
    }
  }
}

data "terraform_remote_state" "instances" {
  backend = "s3"

  config = {
    bucket                      = "terraform-remote-state"
    key                         = "task2/terraform.tfstate"
    region                      = "us-east-1"
    profile                     = "localstack"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    endpoints = {
      s3 = "http://s3.localhost.localstack.cloud:4566"
    }
  }
}
