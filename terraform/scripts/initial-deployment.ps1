# Installs Prerequisite modules for Microsoft 365 DSC to operate

Install-PackageProvider NuGet -Force
Install-Module PowerShellGet -Force
Install-Module Az.Keyvault -Force
Install-Module Az.Resources -Force
Install-Module Microsoft365DSC -Force

Update-M365DSCDependencies