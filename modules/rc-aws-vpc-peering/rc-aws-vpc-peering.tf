

#### Redis Cloud Subscription Peering

# # Configure the rediscloud provider:
# provider "rediscloud" {
#     api_key = var.rediscloud_creds[0]
#     secret_key = var.rediscloud_creds[1]
# }

# ## enter customers existing subscription name here
# data "rediscloud_subscription" "example" {
#   name = var.rediscloud_subscription_name
# }

# ## if you want to see the output of the sub id
# output "rediscloud_subscription" {
#   value = data.rediscloud_subscription.example.id
# }
# output "rediscloud_subscription_networking_deployment_cidr" {
#   value = data.rediscloud_subscription.example.cloud_provider[0].region
# }

resource "rediscloud_subscription_peering" "example" {
   subscription_id = var.rediscloud_subscription_id
   region = var.aws_customer_application_vpc_region
   aws_account_id = var.aws_customer_application_aws_account_id
   vpc_id = var.aws_customer_application_vpc_id
   vpc_cidr = var.aws_customer_application_vpc_cidr
}


resource "aws_vpc_peering_connection_accepter" "example-peering" {
  vpc_peering_connection_id = rediscloud_subscription_peering.example.aws_peering_id
  auto_accept               = true
}

### AWS Terrafrom to add route table in customer AWS environment
### ADD ROUTE TABLE ROUTE

# # AWS region and AWS key pair
# provider "aws" {
#   region = var.aws_vpc_region
#   access_key = var.aws_creds[0]
#   secret_key = var.aws_creds[1]
# }


# Declare the data source
data "aws_vpc_peering_connection" "pc" {
  peer_vpc_id = var.aws_customer_application_vpc_id
  status = "active"
  depends_on = [aws_vpc_peering_connection_accepter.example-peering]
}

## if you want to see the output of the sub id
output "aws_vpc_peering_connection" {
  value = data.aws_vpc_peering_connection.pc.id
}

# Create a route
resource "aws_route" "r" {
  route_table_id            = var.aws_vpc_route_table_id
  destination_cidr_block    = var.rc_networking_deployment_cidr
  vpc_peering_connection_id = data.aws_vpc_peering_connection.pc.id
}