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

$rulesets = Get-PowerAppsCheckerRulesets -Geography $global:Geography
$rulesetToUse = $rulesets | where Name -EQ "Solution Checker"
$overrides = New-PowerAppsCheckerRuleLevelOverride -Id 'meta-avoid-silverlight' -OverrideLevel High #Use this to Override Rules and set a Higher or Lower Level
$analyzeResult = Invoke-PowerAppsChecker -Geography Australia -ClientApplicationId $aadPowerAppId `
    -TenantId $aadTenant -Ruleset $rulesetToUse -FileUnderAnalysis $env:SYSTEM_DEFAULTWORKINGDIRECTORY\PackageDeployer\bin\Release\PkgFolder\$global:SolutionName.zip `
    -OutputDirectory $env:SYSTEM_DEFAULTWORKINGDIRECTORY\PackageDeployer\bin\Release\PkgFolder\CheckResults -ClientApplicationSecret (ConvertTo-SecureString -AsPlainText -Force -String $aadPowerAppSecret) -RuleLevelOverrides $overrides 

Write-Output $analyzeResult.IssueSummary  

if ($analyzeResult.IssueSummary.HighIssueCount -gt 0) {
    $errorCount = $analyzeResult.IssueSummary.HighIssueCount
    $errorMessage = @"
    You have $errorCount High Issues in your Solution    
    You can review the results by getting the output from $env:SYSTEM_DEFAULTWORKINGDIRECTORY\PackageDeployer\bin\Release\PkgFolder\CheckResults in the Pipeline Artifacts. Results can be analysed using http://sarifviewer.azurewebsites.net/
"@
    Write-Host "##[warning] $errorMessage"
    Write-Host "##vso[task.logissue type=warning;] $errorMessage"    
}

if ($analyzeResult.IssueSummary.CriticalIssueCount -gt 0) {
    $errorCount = $analyzeResult.IssueSummary.CriticalIssueCount
    $errorMessage = @"
    You have $errorCount Critical Issues in your Solution    
    You can review the results by getting the output from $env:SYSTEM_DEFAULTWORKINGDIRECTORY\PackageDeployer\bin\Release\PkgFolder\CheckResults in the Pipeline Artifacts. Results can be analysed using http://sarifviewer.azurewebsites.net/
"@
    Write-Host "##[error] $errorMessage"
    Write-Host "##vso[task.logissue type=error;] $errorMessage"
    Write-Error $errorMessage
}

Remove-Item nuget.exe
Remove-Item .\Tools -Force -Recurse -ErrorAction Ignore
