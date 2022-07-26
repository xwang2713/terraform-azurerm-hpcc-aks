admin = {
  name  = "hpcctfvnetci"
  email = "hpccbuilds@lexisnexis.com"
}

metadata = {
  project             = "hpcctfvnetci"
  product_name        = "vnet"
  business_unit       = "commercial"
  environment         = "sandbox"
  market              = "us"
  product_group       = "contoso"
  resource_group_type = "app"
  sre_team            = "hpccplatform"
  subscription_type   = "dev"
}

tags = { "justification" = "testing" }

resource_group = {
  unique_name = true
  location    = "eastus"
}

provider "azurerm" {
  tenant_id       = "bc877e61-f6cf-4461-accd-0565fa4ca357"
  subscription_id = "ec0ba952-4ae9-4f69-b61c-4b96ff470038"
  client_id       = "025881d1-4538-4bee-8194-b1d89351603e"
  client_secret   = "867c47a0-b204-4237-801a-0b905bc68643"

  features {}
}
