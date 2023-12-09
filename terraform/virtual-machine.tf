/*

resource "azurerm_network_interface" "vm-nic" {
  name                = "nic-dsc-runner"
  location            = azurerm_resource_group.m365dsc.location
  resource_group_name = azurerm_resource_group.m365dsc.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.m365dsc.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "dsc-runner" {
  name                = "vm-uks-m365dsc"
  resource_group_name = azurerm_resource_group.m365dsc.name
  location            = azurerm_resource_group.m365dsc.location
  size                = "Standard_B2ms"
  admin_username      = var.vm_admin_user
  admin_password      = var.vm_admin_password
  network_interface_ids = [
    azurerm_network_interface.vm-nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
*/