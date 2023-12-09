data "terraform_remote_state" "dns-iac" {
  backend = "azurerm"

  config = {
    storage_account_name = "stwhitefamterraform"
    container_name       = "tfstate"
    key                  = "dns-iac.tfstate"

  }
}
