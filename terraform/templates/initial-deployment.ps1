# Installs Prerequisite modules for Microsoft 365 DSC to operate
Install-PackageProvider NuGet -Force
Install-Module PowerShellGet -Force
Install-Module Az.Keyvault -Force
Install-Module Az.Resources -Force
Install-Module Microsoft365DSC -Force

# Create new local user
$password = ConvertTo-SecureString -AsPlainText -String "${azdo_svcpass}" -Force
if (Get-LocalUser -Name "${azdo_svcuser}" -ErrorAction SilentlyContinue) {
    Set-LocalUser -Name "${azdo_svcuser}" -Password $password
}
else {
    New-LocalUser -Name "${azdo_svcuser}" -Description "Azure DevOps Service Account" -Password $password
}

if (-not (Get-LocalGroupMember -Group "Administrators" -Member "${azdo_svcuser}" )) {
    Add-LocalGroupMember -Group "Administrators" -Member "${azdo_svcuser}"
}

#Update Dependent Modules for M365DS
Update-M365DSCDependencies

#Create new agent directory
New-Item -ItemType Directory -Path c:\agent -Force
New-Item -ItemType Directory -Path c:\downloads -Force


# Download AzureDevOps Runner
$destination = "c:\downloads\agent.zip"
$release = Invoke-RestMethod -Uri "https://api.github.com/repos/microsoft/azure-pipelines-agent/releases/latest" -UseBasicParsing
if ($release.body -match "https:\/\/.*win-x64.*.zip" ) {
    Start-BitsTransfer -Source $matches[0] -Destination $destination -Priority Foreground
}
else {
    exit 1
}

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($destination, "c:\agent")

Set-Location -Path "c:\agent"

Start-Process -FilePath ".\config.cmd" -ArgumentList "--unattended --url ${azdo_url} --auth pat --token ${azdo_token} --pool ${azdo_pool} --agent $($env:COMPUTERNAME) --replace --runAsService --windowsLogonAccount `".\${azdo_svcuser}`" --windowsLogonPassword `"${azdo_svcpass}`""