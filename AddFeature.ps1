Param(
    [string] [Parameter(Mandatory = $false)] $Branch = "master"
)

$sourceFile = Invoke-WebRequest "https://raw.githubusercontent.com/dylanhaskins/PowerPlatformCICD/$branch/AddFeature.ps1" -UseBasicParsing:$true
Set-Content .\AddFeature.ps1 -Value $sourceFile.Content

$sourceFile = Invoke-WebRequest "https://raw.githubusercontent.com/dylanhaskins/PowerPlatformCICD/$branch/AddFeature_Full.ps1" -UseBasicParsing:$true
Set-Content .\AddFeature_Full.ps1 -Value $sourceFile.Content

Start-Sleep -Seconds 2

& .\AddFeature_Full.ps1 -Branch $Branch

