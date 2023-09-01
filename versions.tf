terraform {
  required_version = ">= 0.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.5.0, <=6.0"
    }
    spotinst = {
      source  = "spotinst/spotinst"
      version = ">= 1.64.0"
    }
  }
}
