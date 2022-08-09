# HPCC Terraform Continue Integration (CI)

## Service Principal
Create a Service Principal if don't have one which should have at least following entries:
- Application (Client) ID
- Tenant ID

Also need Subscription ID which should be found in Azure Subscription

### Github Secrets
Normally you should save "Client ID", "Tenant ID" and "Subscription ID" to github secrets: from <github reop>/settings/secrets/action create
- AZURE_CLIENT_ID
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

## Azure Login with Service Principal in github action

```code
...
jobs:    

  Terraform-CI:
    name: "Terraform CI"
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