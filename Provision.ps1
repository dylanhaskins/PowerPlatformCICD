Param(
    [boolean] [Parameter(Mandatory = $false)] $PerformInstall = $false,
    [string] [Parameter(Mandatory = $false)] $Branch = "master"
)

$sourceFile = Invoke-WebRequest "https://github.com/dylanhaskins/PowerPlatformCICD/raw/$branch/Provision.ps1"
Set-Content .\Provision.ps1 -Value $sourceFile.Content

$sourceFile = Invoke-WebRequest "https://github.com/dylanhaskins/PowerPlatformCICD/raw/$branch/Provision_Full.ps1"
Set-Content .\Provision_Full.ps1 -Value $sourceFile.Content

Start-Sleep -Seconds 2

& .\Provision_Full.ps1 -PerformInstall $PerformInstall -Branch $Branch
