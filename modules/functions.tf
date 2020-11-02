/*
data "azurerm_storage_account_sas" "sas" {
    connection_string = azurerm_storage_account.sa1.primary_access_key
    https_only = true
    start = "2019-01-01"
    expiry = "2021-12-31"
    resource_types {
        object = true
        container = false
        service = false
    }
    services {
        blob = true
        queue = false
        table = false
        file = false
    }
    permissions {
        read = true
        write = false
        delete = false
        list = false
        add = false
        create = false
        update = false
        process = false
    }
}
*/
resource "azurerm_app_service_plan" "consumption_linux_plan" {
  name                = var.consumption_linux_plan
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  kind                = var.consumption_linux_plan_kind
  reserved = true

  sku {
    tier = var.consumption_linux_plan_sku_tier
    size = var.consumption_linux_plan_sku_size
  }
}

resource "azurerm_function_app" "consumption_linux_function" {
  name                       = var.consumption_linux_function_name
  location                   = azurerm_resource_group.rg1.location
  resource_group_name        = azurerm_resource_group.rg1.name
  app_service_plan_id        = azurerm_app_service_plan.consumption_linux_plan.id
  storage_account_name       = azurerm_storage_account.sa1.name
  storage_account_access_key = azurerm_storage_account.sa1.primary_access_key
  os_type                    = var.consumption_linux_function_os_type
  version = var.consumption_linux_function_version
  site_config {
    linux_fx_version = "PYTHON|3.8"
    use_32_bit_worker_process = false
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      data.azurerm_user_assigned_identity.read_write.id
    ]
  }
  app_settings = {
    saConnectionStr = ""
    blob_sa_name = "drhfunctiontesting"
    srcContainerNameValue = "source"
    srcPrefixNameValue = "transfer"
    dstContainerNameValue = "destination"
    FUNCTIONS_WORKER_RUNTIME = "python"
    #HASH = "${base64encode(filesha256("${var.functionapp}"))}" TODO create zip and place in ./build folder
  }
}

/*
resource "azurerm_app_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name 
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  sku {
    tier = var.app_service_plan_sku_tier #"Standard"
    size = var.app_service_plan_sku_size #"S1"
  }
}

resource "azurerm_function_app" "app_service_function" {
  name                       = var.app_service_function_name
  location                   = azurerm_resource_group.vnet_infra.location
  resource_group_name        = azurerm_resource_group.vnet_infra.name
  app_service_plan_id        = azurerm_app_service_plan.app_service_plan.id
  storage_account_name       = var.functions_storage_account_name
  storage_account_access_key = var.functions_storage_account_primary_access_key
}

##
resource "azurerm_app_service_plan" "consumption_plan" {
  name                = var.consumption_plan_name #"azure-functions-test-consumption-plan"
  location            = azurerm_resource_group.vnet_infra.location
  resource_group_name = azurerm_resource_group.vnet_infra.name
  kind                = var.consumption_plan_kind #"FunctionApp"

  sku {
    tier = var.consumption_plan_sku_tier #"Dynamic"
    size = var.consumption_plan_sku_size #"Y1"
  }
}


resource "azurerm_function_app" "consumption_function" {
  name                       = var.consumption_function_name #"test-azure-consumption-functions"
  location                   = azurerm_resource_group.vnet_infra.location
  resource_group_name        = azurerm_resource_group.vnet_infra.name
  app_service_plan_id        = azurerm_app_service_plan.consumption_plan.id
  storage_account_name       = var.functions_storage_account_name
  storage_account_access_key = var.functions_storage_account_primary_access_key
}
*/