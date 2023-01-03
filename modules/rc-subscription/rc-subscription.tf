
data "rediscloud_payment_method" "card" {
  card_type = var.cc_type
  last_four_numbers = var.cc_last_4
}

resource "rediscloud_subscription" "example" {

  name = var.rediscloud_subscription_name
  payment_method = "credit-card"
  payment_method_id = data.rediscloud_payment_method.card.id
  memory_storage = var.rc_memory_storage

  cloud_provider {
    provider = var.rc_cloud_account_provider_type
    cloud_account_id = var.rc_cloud_account_id
    region {
      region = var.rc_region
      networking_deployment_cidr = var.rc_networking_deployment_cidr
      preferred_availability_zones = var.rc_preferred_availability_zones
      multiple_availability_zones  = true
    }
  }

  // This block needs to be defined for provisioning a new subscription.
  // This allows creating a well-optimised hardware specification for databases in the cluster
  creation_plan {
    average_item_size_in_bytes = var.average_item_size_in_bytes
    memory_limit_in_gb = var.memory_limit_in_gb
    quantity = var.quantity
    replication= var.replication
    support_oss_cluster_api= var.support_oss_cluster_api
    throughput_measurement_by = var.throughput_measurement_by
    throughput_measurement_value = var.throughput_measurement_value
    modules = var.rc_modules
  }
}