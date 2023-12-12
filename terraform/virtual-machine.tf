

resource "azurerm_network_interface" "vm-nic" {
  name                = "nic-dsc-runner"
  location            = azurerm_resource_group.m365dsc.location
  resource_group_name = azurerm_resource_group.m365dsc.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.m365dsc.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}


resource "azurerm_windows_virtual_machine" "dsc-runner" {
  name                = "vm-uks-m365dsc"
  resource_group_name = azurerm_resource_group.m365dsc.name
  location            = azurerm_resource_group.m365dsc.location
  size                = "Standard_B2ms"
  admin_username      = var.vm_admin_user
  admin_password      = var.vm_admin_password
  identity {
    type = "SystemAssigned"
  }
  network_interface_ids = [
    azurerm_network_interface.vm-nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  secret {
    key_vault_id = azurerm_key_vault.dsc-keyvault.id
    certificate {
      store = "My"
      url = azurerm_key_vault_certificate.DSCCertificate.secret_id
    }
    dynamic "certificate" {
      for_each = var.tenants
      content {
        store = "My"
        url = azurerm_key_vault_certificate.tenant-certificate[certificate.value.tenant-name].secret_id
      }
    }
    #certificate {
    #  store = "/LocalMachine/My"
    #  url = ""
    #}
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_public_ip" "example" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.m365dsc.name
  location            = azurerm_resource_group.m365dsc.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_virtual_machine_extension" "install_M365DSC" {
  name                 = "install_M365DSC"
#  resource_group_name  = azurerm_resource_group.main.name
  virtual_machine_id   = azurerm_windows_virtual_machine.dsc-runner.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<SETTINGS
  {    
    "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.initial-deployment.rendered)}')) | Out-File -filepath deploy.ps1\" && powershell -ExecutionPolicy Unrestricted -File deploy.ps1"
  }
  SETTINGS
}