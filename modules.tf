


######## Redis Cloud Account Information
####### Used in the terraform modules
data "rediscloud_cloud_account" "account" {
  exclude_internal_account = true
  provider_type = "AWS"
}

output "rc_cloud_account_id" {
  value = data.rediscloud_cloud_account.account.id
}

output "rc_cloud_account_provider_type" {
  value = data.rediscloud_cloud_account.account.provider_type
}

output "cloud_account_access_key_id" {
  value = data.rediscloud_cloud_account.account.access_key_id
}


########### VPC Module
#### create a brand new VPC, use its outputs in future modules
#### If you already have an existing VPC, comment out and
#### enter your VPC params in the future modules
module "aws-vpc" {
    source             = "./modules/aws-vpc"
    aws_creds          = var.aws_creds
    owner              = var.owner
    region             = var.aws_customer_application_vpc_region
    prefix_name        = var.prefix_name
    vpc_cidr           = var.aws_customer_application_vpc_cidr
    subnet_cidr_blocks = var.subnet_cidr_blocks
    subnet_azs         = var.subnet_azs
}

### VPC outputs 
### Outputs from VPC outputs.tf, 
### must output here to use in future modules)
output "subnet-ids" {
  value = module.aws-vpc.subnet-ids
}

output "vpc-id" {
  value = module.aws-vpc.vpc-id
}

output "vpc_name" {
  description = "get the VPC Name tag"
  value = module.aws-vpc.vpc-name
}

output "route-table-id" {
  description = "route table id"
  value = module.aws-vpc.route-table-id
}

############################ Redis Cloud Subscription
#### Provision an empty (no db) Redis Cloud subscription (1 VPC with 3+ Redis Enterprise Nodes (VMs))
#### The db paramters are used to define the subscription creation plan
#### ie. the size (Size and number of Redis Enterprise Nodes)
module "rc-subscription" {
    source                          = "./modules/rc-subscription"
    rc_cloud_account_id             = data.rediscloud_cloud_account.account.id
    rc_cloud_account_provider_type  = data.rediscloud_cloud_account.account.provider_type
    rediscloud_subscription_name    = var.rediscloud_subscription_name
    cc_type                         = var.cc_type
    cc_last_4                       = var.cc_last_4
    rc_region                       = var.rc_region
    rc_networking_deployment_cidr   = var.rc_networking_deployment_cidr
    rc_preferred_availability_zones = var.rc_preferred_availability_zones
    ########################### Default "creation plan" values set to largest infra for minimum cost flex plan
    ########################### (Feel free to update)
    # rc_memory_storage               = var.rc_memory_storage
    # average_item_size_in_bytes      = var.average_item_size_in_bytes
    # memory_limit_in_gb              = var.memory_limit_in_gb
    # quantity                        = var.quantity
    # replication                     = var.replication
    # support_oss_cluster_api         = var.support_oss_cluster_api
    # throughput_measurement_by       = var.throughput_measurement_by
    # throughput_measurement_value    = var.throughput_measurement_value
    # rc_modules                      = var.rc_modules

    depends_on = [
      data.rediscloud_cloud_account.account
    ]
}

#outputs
# output the Redis Cloud Subscription ID to be used in additional modules
output "rediscloud_subscription_id" {
  value = module.rc-subscription.rediscloud_subscription_id
}

################################## VPC PEERING
############## Redis Cloud VPC peering to Application VPC in AWS account
########## This requires adding a route to the applicaiton VPC in the customers AWS account
module "rc-aws-vpc-peering" {
    source                                  = "./modules/rc-aws-vpc-peering"
    rediscloud_subscription_id              = module.rc-subscription.rediscloud_subscription_id
    aws_customer_application_vpc_region     = var.aws_customer_application_vpc_region
    aws_customer_application_aws_account_id = var.aws_customer_application_aws_account_id
    aws_customer_application_vpc_id         = module.aws-vpc.vpc-id
    aws_customer_application_vpc_cidr       = var.aws_customer_application_vpc_cidr
    rc_networking_deployment_cidr           = var.rc_networking_deployment_cidr
    aws_vpc_route_table_id                  = module.aws-vpc.route-table-id

    depends_on = [
      module.aws-vpc, module.rc-subscription
    ]
}

###########
########### Create a Redis Enterprise database in the Redis Cloud Subscription
########### To scale or update the db, simply update the parameters after it has been created.
module "rc-create-db" {
    source                                      = "./modules/rc-create-db"
    rediscloud_subscription_id                  = module.rc-subscription.rediscloud_subscription_id
    rc_db_average_item_size_in_bytes            = var.rc_db_average_item_size_in_bytes
    rc_db_replication                           = var.rc_db_replication
    rc_db_external_endpoint_for_oss_cluster_api = var.rc_db_external_endpoint_for_oss_cluster_api
    rc_db_support_oss_cluster_api               = var.rc_db_support_oss_cluster_api
    rc_db_throughput_measurement_value          = var.rc_db_throughput_measurement_value
    rc_db_throughput_measurement_by             = var.rc_db_throughput_measurement_by
    rc_db_data_persistence                      = var.rc_db_data_persistence
    rc_db_memory_limit_in_gb                    = var.rc_db_memory_limit_in_gb
    rc_db_name                                  = var.rc_db_name
    rc_db_modules                               = var.rc_db_modules

    depends_on = [
      module.rc-subscription
    ]
}
