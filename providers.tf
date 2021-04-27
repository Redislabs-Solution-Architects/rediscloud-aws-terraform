terraform {
 required_providers {
   rediscloud = {
     source = "RedisLabs/rediscloud"
     version = "0.2.0"
   }
 }
}

# Configure the rediscloud provider:
provider "rediscloud" {
    api_key = var.rediscloud_creds[0]
    secret_key = var.rediscloud_creds[1]
}