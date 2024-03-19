variable "subscription_id" {
  type = string
  description = "Azure Subscription ID to connect to"
  sensitive = false
}
variable "client_id" {
    type = string
    description = "Client ID for Managed Identity to connect to Azure"
    sensitive = true
}

variable "client_secret" {
  type = string
  description = "Client Secret for Managed Identity"
  sensitive = true
}

variable "tenant_id" {
    type = string
    description = "GUID of the Azure Tenatnt to deploy to"
    sensitive = false
}

variable "storage_account" {
  type = string
  description = "name of azure storage account hosting state"
  
}

variable "vm_admin_user" {
  type = string
  description = "Administrative username for virtual machine"
  sensitive = false
}

variable "vm_admin_password" {
  type = string
  description = "password for vm"
  sensitive = true
}

variable "dsc_admin_password" {
  type = string
  description = "password for m365dscadmin user"
  sensitive = true
}

variable "keyvault-admin" {
  type = string
  description = "Admin user format"
}

variable "graph-permissions" {
  type = list(string)
  description = "List of strings of EntraID roles to add to the M365 DSC App Registration" 
}

variable "tenants" {
  type = list(object({
    tenant-name = string
    dsc-admin-username = string
    dsc-admin-password = string
    graph-permissions = list(string)
  }))
}

variable "azdo_url" {
  type = string
  description = "URL of the AzureDevOps Organisation"
}

variable "azdo_token" {
  type = string
  sensitive = true
  description = "PAT token to register the Runner"
}

variable "azdo_pool" {
  type = string
  description = "Pool to add the Self-Hosted Pipline agent to"
}

variable "azdo_svcuser" {
  type = string
  description = "username for service account"
  default = "svcAzureDevOps"
}

variable "azdo_svcpass" {
  type = string
  description = "password for service account"
  sensitive = true
}

variable "m365dsc_version" {
  type = string
  description = "The version of Microsoft 365DSC to deploy"
  sensitive = false
}