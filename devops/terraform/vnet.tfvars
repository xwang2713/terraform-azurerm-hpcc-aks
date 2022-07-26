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
