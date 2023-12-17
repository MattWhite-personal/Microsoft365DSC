resource "azurerm_key_vault" "dsc-keyvault" {
  name                        = "kv-uks-whitefam-m365dsc"
  location                    = azurerm_resource_group.m365dsc.location
  resource_group_name         = azurerm_resource_group.m365dsc.name
  enabled_for_disk_encryption = true
  enabled_for_deployment      = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "Create", "List", "Update"
    ]

    secret_permissions = [
      "Get", "Set"
    ]

    certificate_permissions = [
      "Get", "Create", "Update", "List"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azuread_user.kv-admin.object_id

    key_permissions = [
      "Get", "Create", "List", "Update"
    ]

    secret_permissions = [
      "Get", "Set", "List"
    ]

    certificate_permissions = [
      "Get", "Create", "Update", "List"
    ]
  }
}

resource "azurerm_private_endpoint" "keyvault" {
  name                = "pe-${azurerm_key_vault.dsc-keyvault.name}"
  resource_group_name = azurerm_resource_group.m365dsc.name
  location            = azurerm_resource_group.m365dsc.location
  subnet_id           = azurerm_subnet.private-endpoint.id
  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [data.terraform_remote_state.dns-iac.outputs.privatezone-keyvault-id]
  }
  private_service_connection {
    is_manual_connection           = false
    private_connection_resource_id = azurerm_key_vault.dsc-keyvault.id
    name                           = "psc-${azurerm_key_vault.dsc-keyvault.name}"
    subresource_names              = ["vault"]
  }
}

resource "azurerm_key_vault_certificate" "DSCCertificate" {
  name         = "DSCCertificate"
  key_vault_id = azurerm_key_vault.dsc-keyvault.id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = 30
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      # Document Encryption = 1.3.6.1.4.1.311.80.1
      extended_key_usage = ["1.3.6.1.4.1.311.80.1"]

      key_usage = [
        "dataEncipherment",
        "keyEncipherment"
      ]

      #subject_alternative_names {
      #  dns_names = ["DSCNode Document Encryption"]
      #}

      subject            = "CN = DSCNode Document Encryption"
      validity_in_months = 120
    }
  }
}

resource "azurerm_key_vault_certificate" "tenant-certificate" {
  for_each     = { for t in var.tenants : t.tenant-name => t }
  name         = each.key
  key_vault_id = azurerm_key_vault.dsc-keyvault.id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = 30
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      # Client Authentication (1.3.6.1.5.5.7.3.2)
      # Server Authentication (1.3.6.1.5.5.7.3.2)

      extended_key_usage = ["1.3.6.1.5.5.7.3.2", "1.3.6.1.5.5.7.3.2"]

      key_usage = [
        "digitalSignature",
        "keyEncipherment"
      ]

      subject            = "CN = ${each.key}"
      validity_in_months = 12
    }
  }
}

resource "azurerm_key_vault_secret" "M365-DSC-ADminPass" {
  for_each     = { for t in var.tenants : t.tenant-name => t }
  name         = "${each.key}-adminpass"
  key_vault_id = azurerm_key_vault.dsc-keyvault.id
  value        = each.value.dsc-admin-password

}
