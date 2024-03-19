resource "azuredevops_project" "M365DSC" {
  name        = "Test Project"
  description = "Managed by Terraform"
  features = {
    "boards"       = "disabled"
    "repositories" = "disabled"
    "testplans"    = "disabled"
    "pipelines"    = "enabled"
    "artifacts"    = "disabled"
  }
}

resource "azuredevops_serviceendpoint_github" "github" {
  project_id            = azuredevops_project.M365DSC.id
  service_endpoint_name = "Example GitHub Personal Access Token"

  auth_personal {
    # Also can be set with AZDO_GITHUB_SERVICE_CONNECTION_PAT environment variable
    personal_access_token = var.github_pat
  }
}

resource "azuredevops_build_definition" "M365dsc-build" {
  project_id = azuredevops_project.M365DSC.id
  name       = "Example Build Definition"
  path       = "\\ExampleFolder"

  ci_trigger {
    use_yaml = false
  }

  repository {
    repo_type             = "GitHub"
    repo_id               = "${var.github_org}/${var.github_repo}"
    branch_name           = "main"
    yml_path              = "DSC/Pipelines/azure-pipeline.yml"
    service_connection_id = azuredevops_serviceendpoint_github.github.id
  }
}

resource "azurerm_user_assigned_identity" "azdo-identity" {
  location            = azurerm_resource_group.m365dsc.location
  name                = "azure-devops-m365dsc-managed-identity"
  resource_group_name = azurerm_resource_group.m365dsc.name
}

resource "azuredevops_serviceendpoint_azurerm" "M365DSC" {
  project_id                             = azuredevops_project.M365DSC.id
  service_endpoint_name                  = "azdo-m365dsc-service-endpoint"
  description                            = "Managed by Terraform"
  service_endpoint_authentication_scheme = "WorkloadIdentityFederation"
  credentials {
    serviceprincipalid = azurerm_user_assigned_identity.azdo-identity.client_id
  }
  azurerm_spn_tenantid      = data.azurerm_client_config.current.tenant_id
  azurerm_subscription_id   = data.azurerm_client_config.current.subscription_id
  azurerm_subscription_name = data.azurerm_subscription.current.display_name
}

resource "azurerm_federated_identity_credential" "example" {
  name                = "example-federated-credential"
  resource_group_name = azurerm_resource_group.m365dsc.name
  parent_id           = azurerm_user_assigned_identity.azdo-identity.id
  audience            = ["api://AzureADTokenExchange"]
  issuer              = azuredevops_serviceendpoint_azurerm.M365DSC.workload_identity_federation_issuer
  subject             = azuredevops_serviceendpoint_azurerm.M365DSC.workload_identity_federation_subject
}