Param(
    [string] [Parameter(Mandatory = $true)] $aadTenant,
    [string] [Parameter(Mandatory = $true)] $aadPowerAppId,
    [string] [Parameter(Mandatory = $true)] $aadPowerAppSecret
)
######################## SETUP 
. "$env:SYSTEM_DEFAULTWORKINGDIRECTORY\Solutions\Scripts\_SetupTools.ps1"
. "$env:SYSTEM_DEFAULTWORKINGDIRECTORY\Solutions\Scripts\_Config.ps1"

InstallCoreTools
InstallPowerAppsCheckerModule

# Support for patches
$packageFolder = "packageSolution"
if (Test-Path $env:SYSTEM_DEFAULTWORKINGDIRECTORY\Solutions\packagePatch\Other\Solution.xml) {
    $packageFolder = "packagePatch"
}

&.\Tools\SolutionPackager.exe /action:pack /folder:$env:SYSTEM_DEFAULTWORKINGDIRECTORY\Solutions\$packageFolder /zipfile:"$env:SYSTEM_DEFAULTWORKINGDIRECTORY\PackageDeployer\bin\Release\PkgFolder\$global:SolutionName.zip" /packagetype:Both /map:$env:SYSTEM_DEFAULTWORKINGDIRECTORY\Solutions\map.xml 

New-Item -ItemType Directory -Force -Path $env:SYSTEM_DEFAULTWORKINGDIRECTORY\PackageDeployer\bin\Release\PkgFolder\CheckResults

$rulesets = Get-PowerAppsCheckerRulesets -Geography Australia
$rulesetToUse = $rulesets | where Name -EQ "Solution Checker"
$analyzeResult = Invoke-PowerAppsChecker -Geography Australia -ClientApplicationId $aadPowerAppId `
    -TenantId $aadTenant -Ruleset $rulesetToUse -FileUnderAnalysis $env:SYSTEM_DEFAULTWORKINGDIRECTORY\PackageDeployer\bin\Release\PkgFolder\$global:SolutionName.zip `
    -OutputDirectory $env:SYSTEM_DEFAULTWORKINGDIRECTORY\PackageDeployer\bin\Release\PkgFolder\CheckResults -ClientApplicationSecret (ConvertTo-SecureString -AsPlainText -Force -String $aadPowerAppSecret)

Write-Output $analyzeResult.IssueSummary  

Remove-Item nuget.exe
Remove-Item .\Tools -Force -Recurse -ErrorAction Ignore
