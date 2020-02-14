#Requires -Version 3.0

Param(
    [string] $ResourceGroupLocation,
    [string] $ResourceGroupName,
    [string] $StorageAccountName,
    [string] $StorageContainerName = $ResourceGroupName.ToLowerInvariant() + '-stageartifacts',
    [string] $TemplateFile = 'azuredeploy.json',
    [string] $TemplateParametersFile = 'azuredeploy.parameters.json'
)

try {
    [Microsoft.Azure.Common.Authentication.AzureSession]::ClientFactory.AddUserAgent("VSAzureTools-$UI$($host.name)".replace(' ','_'), '3.0.0')
} catch { }

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 3

function Format-ValidationOutput {
    param ($ValidationOutput, [int] $Depth = 0)
    Set-StrictMode -Off
    return @($ValidationOutput | Where-Object { $_ -ne $null } | ForEach-Object { @('  ' * $Depth + ': ' + $_.Message) + @(Format-ValidationOutput @($_.Details) ($Depth + 1)) })
}

$OptionalParameters = New-Object -TypeName Hashtable
$TemplateFile = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($PSScriptRoot, $TemplateFile))
$TemplateParametersFile = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($PSScriptRoot, $TemplateParametersFile))

# Create the resource group only when it doesn't already exist
if ((az group show --resource-group $ResourceGroupName --verbose) -eq $null) {
    az group create --name $ResourceGroupName --location $ResourceGroupLocation --verbose
}


    $ValidationResults = (az group deployment validate --resource-group $ResourceGroupName `
                                                                                  --template-file $TemplateFile `
                                                                                  --parameters @$TemplateParametersFile `
                                                                                  --handle-extended-json-format | ConvertFrom-Json) 
    if ($ValidationResults.error) {
        Write-Output '', 'Validation returned the following errors:', @($ValidationResults.error), '', 'Template is invalid.'
    }
    else {
        Write-Output '', 'Template is valid.'

    $DeploymentResult = (az group deployment create --name ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm')) `
                                       --resource-group $ResourceGroupName `
                                       --template-file $TemplateFile `
                                       --parameters @$TemplateParametersFile `
                                       --handle-extended-json-format) | ConvertFrom-Json
    if ($DeploymentResult.properties.provisioningState -eq "Succeeded") {
        Write-Output '', 'Deployment completed successfuly'
    }

    }


