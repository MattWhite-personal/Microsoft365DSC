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