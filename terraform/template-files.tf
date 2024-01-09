data "local_file" "deployment" {
  filename = "scripts/initial-deployment.ps1"
}

data "template_file" "initial-deployment" {
  template = data.local_file.deployment.content
  vars = {
    azdo_pool = var.azdo_pool
    azdo_svcuser = var.azdo_svcuser
    azdo_svcpass = var.azdo_svcpass
    azdo_token = var.azdo_token
    azdo_url = var.azdo_url
  }
}

data "local_file" "configureLCM" {
  filename = "scripts/ConfigureLCM.ps1"
}

data "template_file" "ConfigureLCM" {
  template = data.local_file.configureLCM.content
  vars = {
    dsc_cert_thumbprint = azurerm_key_vault_certificate.DSCCertificate.thumbprint
  }
}

data "template_file" "DSC-Datafile" {
    for_each     = { for t in var.tenants : t.tenant-name => t }
    template = file(templates/DSC-DataFile.psd1)
  
}