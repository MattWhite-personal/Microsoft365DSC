data "azuread_user" "kv-admin" {
  user_principal_name = var.keyvault-admin
}

data "http" "public_ip" {
  url = "https://api.ipify.org/?format=json"
  request_headers = {
    Accept = "application/json"
  }
}

data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}
