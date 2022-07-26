#provider "azurerm" {
#  features {}
#}

provider "azurerm" {
  tenant_id       = "bc877e61-f6cf-4461-accd-0565fa4ca357"
  subscription_id = "ec0ba952-4ae9-4f69-b61c-4b96ff470038"
  client_id       = "025881d1-4538-4bee-8194-b1d89351603e"
  client_secret   = "867c47a0-b204-4237-801a-0b905bc68643"

  features {}
}
provider "kubernetes" {
  host                   = module.kubernetes.kube_config.host
  client_certificate     = base64decode(module.kubernetes.kube_config.client_certificate)
  client_key             = base64decode(module.kubernetes.kube_config.client_key)
  cluster_ca_certificate = base64decode(module.kubernetes.kube_config.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = module.kubernetes.kube_config.host
    client_certificate     = base64decode(module.kubernetes.kube_config.client_certificate)
    client_key             = base64decode(module.kubernetes.kube_config.client_key)
    cluster_ca_certificate = base64decode(module.kubernetes.kube_config.cluster_ca_certificate)
  }
}
