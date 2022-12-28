
##### Terraform providers for rediscloud and aws
terraform {
 required_providers {
   rediscloud = {
     source = "RedisLabs/rediscloud"
     version = "1.0.1"
     }
   aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
      }
  }
}

#### configure the AWS provider
#### AWS region and AWS key pair
provider "aws" {
  region     = var.aws_customer_application_vpc_region
  access_key = var.aws_creds[0]
  secret_key = var.aws_creds[1]
}


#### Configure the rediscloud provider:
#### go to your Redis Cloud Account >  Access Managment > API Keys > 
#### create new API Key (this gives you the secret key, the API_key is the API account key)
provider "rediscloud" {
    api_key = var.rediscloud_creds[0]
    secret_key = var.rediscloud_creds[1]
}

