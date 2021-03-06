
variable "region" {
  default     = "us-east-1"
  description = "The region to deploy the cluster in, e.g: us-east-1."
}


variable "environment" {
  default     = "dev"
  description = "environment name"
}


terraform {
  required_version = ">= 0.10.5"
  backend "s3" {
    bucket = "myterraform-state-2020"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true

  }
}

data "terraform_remote_state" "default" {
  backend = "s3"
  config {
    bucket = "myterraform-state-2020"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}


# Define your AWS profile here
provider "aws" {
  region  = "us-east-1"
  version = "~> 1.3.0"
}



data "aws_ssm_parameter" "db_username" {
  name  = "${var.environment}.db.username"
}

data "aws_ssm_parameter" "db_password" {
  name  = "${var.environment}.db.password"
}
