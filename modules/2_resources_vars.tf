variable "rg1_name" {}
variable "rg1_location" {}
variable "permanent_infra_key_vault_name" {}
variable "permanent_infra_rg_name" {}
variable "davids_home_ip_secret_name" {}
variable "shanikas_home_ip_secret_name" {}

#storage
variable "sa2_name" {}
variable "sa1_name" {}
variable "container1_name" {}
variable "container2_name" {}
variable "sa1_environment_tag" {}

# functions
variable "consumption_linux_plan" {}
variable "consumption_linux_plan_kind" {}
variable "consumption_linux_plan_sku_tier" {}
variable "consumption_linux_plan_sku_size" {}
variable "consumption_linux_function_name" {}
variable "consumption_linux_function_os_type" {}

#scratch
/*
variable "app_service_plan_name" {}
variable "app_service_plan_sku_tier" {}
variable "app_service_plan_sku_size" {}
variable "app_service_function_name" {}
variable "functions_storage_account_name" {}
variable "functions_storage_account_primary_access_key" {}
variable "consumption_plan_name" {}
variable "consumption_plan_kind" {}
variable "consumption_plan_sku_tier" {}
variable "consumption_plan_sku_size" {}
variable "consumption_function_name" {}
*/