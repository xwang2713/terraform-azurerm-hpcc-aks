terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      #version = "<=2.99.0"
      version = ">=3.15.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.1.0"
    }
  }
  required_version = ">=0.15.0"

  backend "azurerm" {
    resource_group_name  = "hpcctfstatesci"
    storage_account_name = "tfstatedevopsci"
    container_name       = "hpcctfbackendci"
    key                  = "hpcctfscci.tfstate"
  }
}
