
# # Provide your credit card details
# data "rediscloud_payment_method" "card" {
#  card_type = "Visa"
#  last_four_numbers = var.cc_last_4
# }
 
# # Generates a random password for the database
# resource "random_password" "passwords" {
#  count = 2
#  length = 20
#  upper = true
#  lower = true
#  number = true
#  special = false
# }
 
# resource "rediscloud_subscription" "example" {
#  name = var.rediscloud_subscription_name
#  payment_method_id = data.rediscloud_payment_method.card.id
#  memory_storage = "ram"
 
#  cloud_provider {
#    #Running in AWS on Redis Labs resources
#    provider = "AWS"
#    # important to know which account you are using!
#    cloud_account_id = var.cloudAccountId
#    region {
#      region = "eu-west-1"
#      networking_deployment_cidr = "10.0.0.0/24"
#      preferred_availability_zones = ["eu-west-1a"]
#    }
#  }


#  database {
#    name = "redis-db"
#    protocol = "redis"
#    memory_limit_in_gb = 1
#    replication = true
#    data_persistence = "none"
#    throughput_measurement_by = "number-of-shards"
#    throughput_measurement_value = 2
#    password = random_password.passwords[0].result
#  }
#  database {
#    name = "db-json"
#    protocol = "redis"
#    memory_limit_in_gb = 1
#    replication = true
#    data_persistence = "aof-every-1-second"
#    module {
#        name = "RedisJSON"
#    }
#    throughput_measurement_by = "operations-per-second"
#    throughput_measurement_value = 10000
#    password = random_password.passwords[1].result
#  }
# }