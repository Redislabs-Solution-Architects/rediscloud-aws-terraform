


# data "rediscloud_payment_method" "card" {
#   card_type = var.cc_type
#   last_four_numbers = var.cc_last_4
# }

# ## enter customers existing subscription name here
# data "rediscloud_subscription" "example" {
#   name = var.rediscloud_subscription_name
# }

# ## if you want to see the output of the sub id
# output "rediscloud_subscription" {
#   value = data.rediscloud_subscription.example.id
# }

# # data "rediscloud_database" "example" {
# #   subscription_id = data.rediscloud_subscription.example.id
# # }

# # output "rediscloud_database" {
# #   value = data.rediscloud_database.example.id
# # }

# ###########
# // The primary database to provision
# resource "rediscloud_subscription_database" "example" {
#     subscription_id = data.rediscloud_subscription.example.id
#     name = "db2tf"
#     protocol = "redis"
#     memory_limit_in_gb = 1
#     data_persistence = "none"
#     throughput_measurement_by = "operations-per-second"
#     throughput_measurement_value = 1000
#     support_oss_cluster_api = false 
#     external_endpoint_for_oss_cluster_api = false
#     replication = true
#     #average_item_size_in_bytes = 0

#     modules = [
#         {
#           name = "RedisJSON"
#         }
#     ]

#     alert {
#       name = "dataset-size"
#       value = 40
#     }

#     #depends_on = [rediscloud_subscription.example]

# }



