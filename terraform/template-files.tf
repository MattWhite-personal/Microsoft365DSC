data "local_file" "deployment" {
  filename = "templates/initial-deployment.ps1"
}

data "template_file" "initial-deployment" {
  template = data.local_file.deployment.content
  vars = {
    azdo_pool = var.azdo_pool
    azdo_svcuser = var.azdo_svcuser
    azdo_svcpass = var.azdo_svcpass
    azdo_token = var.azdo_token
    azdo_url = var.azdo_url
    dsc_cert_thumbprint = azurerm_key_vault_certificate.DSCCertificate.thumbprint
    m365dsc_version = var.m365dsc_version
  }
}