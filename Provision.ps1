Param(
    [boolean] [Parameter(Mandatory = $false)] $PerformInstall = $false,
    [string] [Parameter(Mandatory = $false)] $Branch = "master"
)

$sourceFile = Invoke-WebRequest "https://raw.githubusercontent.com/dylanhaskins/PowerPlatformCICD/$branch/Provision.ps1" -UseBasicParsing:$true
Set-Content .\Provision.ps1 -Value $sourceFile.Content

$sourceFile = Invoke-WebRequest "https://raw.githubusercontent.com/dylanhaskins/PowerPlatformCICD/$branch/Provision_Full.ps1" -UseBasicParsing:$true
Set-Content .\Provision_Full.ps1 -Value $sourceFile.Content

Start-Sleep -Seconds 2

& .\Provision_Full.ps1 -PerformInstall $PerformInstall -Branch $Branch

