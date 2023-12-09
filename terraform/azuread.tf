data "azuread_client_config" "current" {}

data "azuread_service_principal" "graphAPI" {
  client_id = "00000003-0000-0000-c000-000000000000"
}

data "azuread_domains" "default_domain" {
    only_default = true
}

resource "azurerm_key_vault_secret" "M365-DSC-ADminPass" {
    for_each = toset(local.tenants)
    name = "${each.value}-adminpass"
    key_vault_id = azurerm_key_vault.dsc-keyvault.id
    value = var.dsc_admin_password
  
}


resource "azuread_user" "M365-DSC-AdminUser" {
  display_name = "[ADM] Microsoft 365 DSC ADmin"
  user_principal_name = "m365dscadmin@${data.azuread_domains.default_domain.domains[0].domain_name}"
  password = azurerm_key_vault_secret.M365-DSC-ADminPass["thewhitefamily"].value
  disable_password_expiration = true
  show_in_address_list = false
  usage_location = "GB"
  surname = "Admin"
  given_name = "DSC"
  account_enabled = false
}

resource "azuread_application" "M365-DSC-Appreg" {
  display_name = "M365DSC-test"

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "df021288-bdef-4463-88db-98f22de89214" # User.Read.All
      type = "Role"
    }

    resource_access {
      id   = "b4e74841-8e56-480b-be8b-910348b18b4c" # User.ReadWrite
      type = "Scope"
    }
    resource_access {
      id   = data.azuread_service_principal.graphAPI.app_role_ids["Directory.Read.All"]
      type = "Role"
    }
  }
  
}

resource "azuread_application_certificate" "M365-DSC-Appreg-cert" {
  application_id = azuread_application.M365-DSC-Appreg.id
  type           = "AsymmetricX509Cert"
  encoding       = "hex"
  value          = azurerm_key_vault_certificate.tenant-certificate["thewhitefamily"].certificate_data
  end_date       = azurerm_key_vault_certificate.tenant-certificate["thewhitefamily"].certificate_attribute[0].expires
  start_date     = azurerm_key_vault_certificate.tenant-certificate["thewhitefamily"].certificate_attribute[0].not_before
}

resource "azuread_application_registration" "M365DSC-Whitefam" {
  display_name = "M365DSC-Whitefam"
  sign_in_audience = "AzureADMyOrg"
  
}

resource "azuread_application_certificate" "M365DSC-Whitefam-cert" {
  application_id = azuread_application_registration.M365DSC-Whitefam.id
  type           = "AsymmetricX509Cert"
  encoding       = "hex"
  value          = azurerm_key_vault_certificate.tenant-certificate["thewhitefamily"].certificate_data
  end_date       = azurerm_key_vault_certificate.tenant-certificate["thewhitefamily"].certificate_attribute[0].expires
  start_date     = azurerm_key_vault_certificate.tenant-certificate["thewhitefamily"].certificate_attribute[0].not_before
}