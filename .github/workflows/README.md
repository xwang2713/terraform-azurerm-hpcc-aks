# HPCC Terraform Continuous Integration (CI)

## Service Principal
Create a Service Principal if don't have one which should have at least following entries:
- Application (Client) ID
- Value (Client Secret)
- Tenant ID

Also need Subscription ID which should be found in Azure Subscription

### Github Secrets
Normally you should save "Client ID", "Tenant ID" and "Subscription ID" to github secrets: from <github reop>/settings/secrets/action create
- AZURE_CLIENT_ID
- AZURE_CLIENT_SECRET
- AZURE_TENANT_ID
- AZURE_SUBSCRIPTION_ID

## App registration/Federated credential
Create a new App registration from Azure Active Directory following
https://docs.microsoft.com/en-us/azure/active-directory/develop/workload-identity-federation-create-trust?tabs=azure-portal&pivots=identity-wif-apps-methods-azp

Fill Certficates & secrets/Federated credentials with
- Github Organization
- Github Repository
- Select "Environment" for "Entity type" and give a string in "Based on selection". Such as "dev" or "production", etc.

When github use Service Principal login it will use "Subject identifier" and "Entity type"/"Baseed on selection" to match your rquest.

## Create Backend Storage Account and Container
One storage account and one container should be enough which defined in hpcc-versions.tf, sc-versions.tf and vnet-versions.tf.
All three define the same storage account and container name but with different keys.



## Azure Login with Service Principal in github action

```code
...
jobs:

  Terraform-CI:
    name: "Terraform CI"
    env:
      ARM_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
      ARM_CLIENT_SECRET: ${{ secrets.SERVICE_PRINCIPAL_VALUE }}
      ARM_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      ARM_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
    runs-on: ubuntu-20.04
    environment: dev
    defaults:
      run:
        shell: bash
    steps:
    - name: 'Az CLI login'
      uses: azure/login@v1
      with:
        client-id: ${{ secrets.AZURE_CLIENT_ID }}
        tenant-id: ${{ secrets.AZURE_TENANT_ID }}
        subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

```
## Known Problem
### HPCC Terraform Destroy May Fail
Error:
```code
│ Error: Get "https://aks-sandbox-eastus-d95c7504.hcp.eastus.azmk8s.io:443/api/v1/namespaces/default/secrets/azure-secret": dial tcp 20.84.21.242:443: connect: connection refused

│   with kubernetes_secret.sa_secret[0],
│   on main.tf line 96, in resource "kubernetes_secret" "sa_secret":
│   96: resource "kubernetes_secret" "sa_secret" {
```
Workaround: manually find and delete the resource group with admin field which defined in admin.name in devops/hpcc.tfvars

### Virtual Network Terraform Destroy May Fail
Error:
```code
│ Error: deleting Subnet: (Name "aks-hpcc-public" / Virtual Network Name "contoso-dev-eastus-vnet" / Resource Group "app-vnet-sandbox-eastus-88243"): network.SubnetsClient#Delete: Failure sending request: StatusCode=400 -- Original Error: Code="InUseSubnetCannotBeDeleted" Message="Subnet aks-hpcc-public is in use by /subscriptions/***/resourceGroups/MC_app-aks-terraform-eastus-hpcctfplatmci1-default/providers/Microsoft.Network/networkInterfaces/|providers|Microsoft.Compute|virtualMachineScaleSets|aks-system-19980251-vmss|virtualMachines|0|networkInterfaces|aks-system-19980251-vmss/ipConfigurations/ipconfig1 and cannot be deleted. In order to delete the subnet, delete all the resources within the subnet. See aka.ms/deletesubnet." Details=[]```
```
If any HPCC or Storage Account resource is not destroyed Virtual Network can't be destroyed. Manually delete HPCC and Storage Account resources first then manually delete the resource group with admin field which defined in admin.name in devops/vnet.tfvars
