terraform {
  required_version = ">= 0.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.39"
    }
    spotinst = {
      source  = "spotinst/spotinst"
      version = ">= 1.45"
    }
  }
}