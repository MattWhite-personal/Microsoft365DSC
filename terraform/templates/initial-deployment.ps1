# Installs Prerequisite modules for Microsoft 365 DSC to operate
Install-PackageProvider NuGet -Force
Install-Module PowerShellGet -Force
Install-Module Az.Keyvault -Force
Install-Module Az.Resources -Force
Install-Module Microsoft365DSC -Force

# Create new local user
$password = ConvertTo-SecureString -AsPlainText -String "${azdo_svcpass}" -Force
if (Get-LocalUser -Name "${azdo_svcuser}" -ErrorAction SilentlyContinue) {
    Set-LocalUser -Name "${azdo_svcuser}" -Password $password -PasswordNeverExpires $true
}
else {
    New-LocalUser -Name "${azdo_svcuser}" -Description "Azure DevOps Service Account" -Password $password -PasswordNeverExpires $true
}

if (-not (Get-LocalGroupMember -Group "Administrators" -Member "${azdo_svcuser}" )) {
    Add-LocalGroupMember -Group "Administrators" -Member "${azdo_svcuser}"
}

#Update Dependent Modules for M365DS
Update-M365DSCDependencies
Uninstall-M365DSCOutdatedDependencies

#Create new agent directory
New-Item -ItemType Directory -Path c:\agent -Force
New-Item -ItemType Directory -Path c:\downloads -Force
New-Item -ItemType Directory -Path c:\M365DSC -Force


# Download AzureDevOps Runner
$destination = "c:\downloads\agent.zip"
$release = Invoke-RestMethod -Uri "https://api.github.com/repos/microsoft/azure-pipelines-agent/releases/latest" -UseBasicParsing
$targetVersion = [version]$release.name.Substring(1)
$AgentListener = "c:\agent\bin\Agent.Listener.exe"
$installupgrade = $false
if (Test-Path $AgentListener) {
    #Something is installed
    $installedVersion = [version](Get-Item $AgentListener).versioninfo.productversion
    if ($targetversion -gt $installedversion) {
        $installupgrade = $true
    }
}
else {
    $installupgrade = $true
}
if ($installupgrade) {
    if ($release.body -match "https:\/\/.*pipelines-agent-win-x64.*.zip" ) {
        $uri = ($release.body.Split("`n|()")) -match "https:\/\/.*pipelines-agent-win-x64.*.zip"
        Start-BitsTransfer -Source $uri -Destination $destination -Priority Foreground
    }
    else {
        exit 1
    }

    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory($destination, "c:\agent")

    Set-Location -Path "c:\agent"

    Start-Process -FilePath ".\config.cmd" -ArgumentList "--unattended --url ${azdo_url} --auth pat --token ${azdo_token} --pool ${azdo_pool} --agent $($env:COMPUTERNAME) --replace --runAsService --windowsLogonAccount `".\${azdo_svcuser}`" --windowsLogonPassword `"${azdo_svcpass}`""
}

#ConfigureLCM
Set-Location -Path "C:\M365DSC"

Configuration ConfigureLCM {
    Import-DscResource -ModuleName PsDesiredStateConfiguration
    node localhost {
        LocalConfigurationManager {
            ConfigurationMode = "ApplyOnly"
            CertificateId = "${dsc_cert_thumbprint}"
        }
    }
}

ConfigureLcm

Set-DscLocalConfigurationManager -Path "C:\M365DSC\ConfigureLCM" -Verbose