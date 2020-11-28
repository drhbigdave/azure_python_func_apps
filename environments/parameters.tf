module "linux_funcs" {
  source                         = "../modules"
  rg1_name                       = "linux_functions"
  rg1_location                   = "East US"
  permanent_infra_key_vault_name = "drh-infra-keyvault1"
  permanent_infra_rg_name        = "permanent_infra"
  davids_home_ip_secret_name     = "davids-home-ip"
  shanikas_home_ip_secret_name   = "shanikas-home-ip"

  #storage
  sa1_name            = "drhnixfuncconfigs"
  sa2_name            = "drhfunctiontesting"
  container1_name     = "source"
  container2_name     = "destination"
  sa1_environment_tag = "python_func_work"

  # functions
  consumption_plan_count      = 1
  consumption_linux_functions = ["drhBlobCopyTf1"]
  consumption_linux_function_values = {
    drhBlobCopyTf1 = {
      name = "drhBlobCopyTf1"
    }
  }
  function_app_count                 = 1
  consumption_linux_plan             = "linux_func_plan1"
  consumption_linux_plan_kind        = "linux"
  consumption_linux_function_version = "~3"
  consumption_linux_plan_sku_tier    = "Dynamic"
  consumption_linux_plan_sku_size    = "Y1" #pricing
  consumption_linux_function_name    = "drhBlobCopyTf1"
  consumption_linux_function_os_type = "linux"
  #functionapp = "../builds/drhBlobCopyTf1.zip"

  #network
  subnet1_name             = "linux_funcs_dot4"
  vnet_rg_name             = "vm_infra"
  vnet_name                = "study_vm_infrastructure"
  subnet1_address_prefixes = ["10.0.4.0/24"]
  subnet1_service_endpoints = [
    "Microsoft.AzureCosmosDB",
    "Microsoft.EventHub",
    "Microsoft.KeyVault",
    "Microsoft.ServiceBus",
    "Microsoft.Sql",
    "Microsoft.Storage",
    "Microsoft.AzureActiveDirectory",
    "Microsoft.Web",
    "Microsoft.CognitiveServices"
  ]
  nsg1_name = "linuxfunctions"

  #rg_vnet1_name                 = "vm_infra"
  #rg_vnet1_location             = "East US"
  #vnet1_name                    = "study_vm_infrastructure"
  #vnet1_subnet_name             = "vm_subnet_dot2"

}
/*
  app_service_plan_name = "drh-appsvc-plan1"
  app_service_plan_sku_tier = "Standard"
  app_service_plan_sku_size = "S1"
  app_service_function_name = "drh-appsvc-plan1-func1"
  functions_storage_account_name = ""
  
  functions_storage_account_primary_access_key
  consumption_plan_name
  consumption_plan_kind
  consumption_plan_sku_tier
  consumption_plan_sku_size
  consumption_function_name
  consumption_linux_plan
  consumption_linux_plan_kind
  consumption_linux_plan_sku_tier
  consumption_linux_plan_sku_size
  consumption_linux_function_name
  consumption_linux_function_os_type
*/


