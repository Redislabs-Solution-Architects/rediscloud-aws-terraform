

variable "cc_type" {
    description = "credit card type"
    default = "Visa"
}

variable "cc_last_4" {
    description = "Last 4 digits for payment method"
}

variable "rediscloud_subscription_name" {
    description = "Name of RedisCloud subscription"
}

variable "rc_cloud_account_id" {
    description = "rediscould account id"
    default = ""
}

variable "rc_cloud_account_provider_type" {
    description = "rc_cloud_account_provider_type"
    default = "AWS"
}
##### Redis Cloud Subscription Variables

variable "rc_region" {
    description = ""
}

variable "rc_networking_deployment_cidr" {
    description = "the CIDR of your RedisCloud deployment"
}

variable "rc_preferred_availability_zones" {
    description = ""
    type        = list(any)
}

variable "rc_memory_storage" {
    description = "ram"
    default = "ram"
}

##### Redis Cloud Database Variables
variable "average_item_size_in_bytes" {
    description = ""
    default = 1
}

variable "memory_limit_in_gb" {
    description = ""
    default = 25
}

variable "quantity" {
    description = ""
    default = 1
}

variable "replication" {
    description = ""
    default = true
}

variable "support_oss_cluster_api" {
    description = ""
    default = false
}

variable "throughput_measurement_by" {
    description = ""
    default = "operations-per-second"
}

variable "throughput_measurement_value" {
    description = ""
    default = 12000
}

variable "rc_modules" {
    description = ""
    type        = list(any)
    default = ["RedisJSON"]
}
