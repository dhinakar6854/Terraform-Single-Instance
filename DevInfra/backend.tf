terraform {
  required_version = "<= 1.4.6" #Forcing which version of Terraform needs to be used
  required_providers {
    aws = {
      version = "<= 5.0.0" #Forcing which version of plugin needs to be used.
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket         = "sreeterraformbucket"
    key            = "devsecops-modules.tfstate"
    region         = "us-east-1"
    dynamodb_table = "devsecopsb33b34_terraform_locks"
    encrypt        = true
  }
}