terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      #version = ">=3.16.0"
      #version = "=2.99.0"
      version = "~>3.6"
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
    key                  = "hpcctfvnetci.tfstate"
  }
}
