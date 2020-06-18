Param(
    [string] [Parameter(Mandatory = $true)] $aadTenant,
    [string] [Parameter(Mandatory = $true)] $aadPowerAppId,
    [string] [Parameter(Mandatory = $true)] $aadPowerAppSecret
)
######################## SETUP 
. (Join-Path $PSScriptRoot "_SetupTools.ps1")
. (Join-Path $PSScriptRoot "_Config.ps1")

$Packages = Get-Content (Join-Path $PSScriptRoot "..\..\deployPackages.json") | ConvertFrom-Json

foreach ($package in $Packages)
{
$PFolder = $package.PackageFolder
$PDest =   $package.DestinationFolder
$PSolution = $package.SolutionName

Write-Host "Archiving ReferenceData data file"
$compressPath  = (Join-Path $PSScriptRoot "..\..\$PFolder\ReferenceData\*")
$destinationPath  = (Join-Path $PSScriptRoot "..\..\PackageDeployer\bin\Release\$PDest\$PSolution.data.zip")
Compress-Archive -Path $compressPath -CompressionLevel Fastest -DestinationPath $destinationPath -Force
}
