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

azure = {
  TENANT_ID = "${{ secrets.AZURE_TENANT_ID }}"
  SUBSCRIPTION_ID = "${{ secrets.AZURE_SUBSCRIPTION_ID }}"
  AAD_SERVICE_PRINCIPAL_CLIENT_ID = "${{ secrets.AZURE_CLIENT_ID }}"
  AAD_SERVICE_PRINCIPAL_CLIENT_SECRET = "${{ secrets.SERVICE_PRINCIPAL_VALUE }}"
  SERVER_ID = "${{ secrets.SERVER_ID }}"
}
