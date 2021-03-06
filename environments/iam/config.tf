
variable "region" {
  default     = "us-east-1"
  description = "The region to deploy the cluster in, e.g: us-east-1."
}



terraform {
  required_version = ">= 0.10.5"
  backend "s3" {
    bucket = "myterraform-state-2020"
    key    = "iam/terraform.tfstate"
    region = "us-east-1"
    encrypt = true

  }
}

data "terraform_remote_state" "default" {
  backend = "s3"
  config {
    bucket = "myterraform-state-2020"
    key    = "iam/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}


# Define your AWS profile here
provider "aws" {
  region  = "us-east-1"
  version = "~> 0.1.4"
}
