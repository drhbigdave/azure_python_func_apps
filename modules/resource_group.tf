resource "azurerm_resource_group" "rg1" {
  name     = var.rg1_name
  location = var.rg1_location
}
/*
resource "azurerm_role_assignment" "rg_read_write_assignment" {
  for_each            = toset(var.consumption_linux_functions)
  scope                = azurerm_storage_account.sa1.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_function_app.consumption_linux_function[each.key].identity[0].principal_id
}
*/