


# data "rediscloud_payment_method" "card" {
#   card_type = "Visa"
#   last_four_numbers = "2094"
# }



# resource "rediscloud_subscription" "example" {

#   name = "bamos-tf"
#   payment_method = "credit-card"
#   payment_method_id = data.rediscloud_payment_method.card.id
#   memory_storage = "ram"

#   cloud_provider {
#     #provider = data.rediscloud_cloud_account.account.provider_type
#     #cloud_account_id = data.rediscloud_cloud_account.account.id
#     provider = "AWS"
#     cloud_account_id = "2"
#     region {
#       region = "us-east-1"
#       networking_deployment_cidr = "10.2.0.0/24"
#       preferred_availability_zones = ["us-east-1a","us-east-1b","us-east-1c"]
#     }
#   }

#   // This block needs to be defined for provisioning a new subscription.
#   // This allows creating a well-optimised hardware specification for databases in the cluster
#   creation_plan {
#     quantity = 1
#     memory_limit_in_gb = 2
#     throughput_measurement_by = "operations-per-second"
#     throughput_measurement_value = 10000
#     replication=true
#     support_oss_cluster_api = false
#     modules = ["RedisJSON", "RedisBloom"]
#   }
# }