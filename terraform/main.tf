terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.78.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.46.0"
    }
  }
  backend "azurerm" {
    storage_account_name = "stwhitefamterraform"
    container_name = "tfstate"
    key            = "m365dsc.tfstate"
  }
}

provider "azurerm" {

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  features {

  }
}

provider "azuread" {
  client_id     = var.client_id
  client_secret = var.client_secret
  tenant_id     = var.tenant_id
}

resource "azurerm_resource_group" "m365dsc" {
  name     = "rg-uks-m365dsc"
  location = "uksouth"
}

data "azurerm_client_config" "current" {}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "keyvault"
  resource_group_name   = data.terraform_remote_state.dns-iac.outputs.rg-dnszones
  private_dns_zone_name = data.terraform_remote_state.dns-iac.outputs.privatezone-keyvault-name
  virtual_network_id    = azurerm_virtual_network.dsc-runner.id
}

locals {
  tenants = ["thewhitefamily", "objectatelier", "theweaversmiths"]
}

data "azuread_user" "kv-admin" {
    user_principal_name = var.keyvault-admin
}