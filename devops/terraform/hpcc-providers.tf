provider "azurerm" {
  tenant_id       = var.azure.tenant_id
  subscription_id = var.azure.subscription_id
  client_id       = var.azure.client_id
  client_secret   = var.azure.client_secret

  features {}
}

provider "kubernetes" {
  host                   = module.kubernetes.kube_config.host
  client_certificate     = base64decode(module.kubernetes.kube_config.client_certificate)
  client_key             = base64decode(module.kubernetes.kube_config.client_key)
  cluster_ca_certificate = base64decode(module.kubernetes.kube_config.cluster_ca_certificate)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "kubelogin"
    args        = ["get-token", "--login", "spn", "--server-id", var.azure.server_id, "--environment", "AzurePublicCloud", "--tenant-id", var.azure.tenant_id]
    env         = local.k8s_exec_auth_env
  }
}

provider "kubectl" {
  host                   = module.kubernetes.kube_config.host
  cluster_ca_certificate = base64decode(module.kubernetes.kube_config.cluster_ca_certificate)
  load_config_file       = false
  apply_retry_count      = 6

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "kubelogin"
    args        = ["get-token", "--login", "spn", "--server-id", var.azure.server_id, "--environment", "AzurePublicCloud", "--tenant-id", var.azure.tenant_id]
    env         = local.k8s_exec_auth_env
  }
}

provider "helm" {
  kubernetes {
    host                   = module.kubernetes.kube_config.host
    client_certificate     = base64decode(module.kubernetes.kube_config.client_certificate)
    client_key             = base64decode(module.kubernetes.kube_config.client_key)
    cluster_ca_certificate = base64decode(module.kubernetes.kube_config.cluster_ca_certificate)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "kubelogin"
      args        = ["get-token", "--login", "spn", "--server-id", var.azure.server_id, "--environment", "AzurePublicCloud", "--tenant-id", var.azure.tenant_id]
      env         = local.k8s_exec_auth_env
    }

  }

  experiments {
    manifest = true
  }
}
