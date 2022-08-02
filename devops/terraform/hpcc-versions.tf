terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<=2.99.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.1.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.5.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }
  }
  required_version = ">=0.15.0"

  backend "azurerm" {
    resource_group_name  = "hpcctfstatesci"
    storage_account_name = "tfstatedevopsci"
    container_name       = "hpcctfbackendci"
    key                  = "hpcctfceci.tfstate"
  }
}