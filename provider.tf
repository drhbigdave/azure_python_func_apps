terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.34.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
    virtual_machine {
      delete_os_disk_on_deletion = true
    }
  }
}