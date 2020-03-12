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

$Packages = Get-Content "$env:SYSTEM_DEFAULTWORKINGDIRECTORY\deployPackages.json" | ConvertFrom-Json

foreach ($package in $Packages)
{
$PFolder = $package.PackageFolder
$PDest =   $package.DestinationFolder
$PSolution = $package.SolutionName
# Support for patches

    if (Test-Path $env:SYSTEM_DEFAULTWORKINGDIRECTORY\$Pfolder\Deployment)
    {
        $Path = "$env:SYSTEM_DEFAULTWORKINGDIRECTORY\$Pfolder\Deployment" 
    }
    if ($PFolder -eq "Solutions")
    {
        $Path = "$env:SYSTEM_DEFAULTWORKINGDIRECTORY\PackageDeployer" 
    }

    if ($Path)
    {
        Write-Host Getting list of Solutions to pack from ImportConfig.xml
        $ImportConfig = Get-ChildItem -Path $Path -Include "ImportConfig.xml" -Recurse
                                
        [xml] $xdoc = (Get-Content -Path "$($ImportConfig.DirectoryName)\ImportConfig.xml")
        $nodes = $xdoc.configdatastorage.solutions.SelectNodes("//configsolutionfile")  
        foreach ($node in $nodes)
        {
            $folder = ($node. solutionpackagefilename).Replace("_managed.zip","").Replace(".zip","")
            $packageFolder = "package$($folder)"
            &.\Tools\SolutionPackager.exe /action:pack /folder:$env:SYSTEM_DEFAULTWORKINGDIRECTORY\$PFolder\$packageFolder /zipfile:"$env:SYSTEM_DEFAULTWORKINGDIRECTORY\PackageDeployer\bin\Release\$PDest\$folder.zip" /packagetype:Both /map:$env:SYSTEM_DEFAULTWORKINGDIRECTORY\$PFolder\map.xml 
        }
    }
    else
    {
        $errorMessage = "Couldn't find Path for Packing Solutions"
        Write-Host "##[error] $errorMessage"
        Write-Host "##vso[task.logissue type=error;] $errorMessage"  
    }

Write-Host "Archiving ReferenceData data file"
$compressPath  = "$env:SYSTEM_DEFAULTWORKINGDIRECTORY\$PFolder\ReferenceData\*"
$destinationPath  = "$env:SYSTEM_DEFAULTWORKINGDIRECTORY\PackageDeployer\bin\Release\$PDest\$PSolution.data.zip"
Compress-Archive -Path $compressPath -CompressionLevel Fastest -DestinationPath $destinationPath -Force

New-Item -ItemType Directory -Force -Path $env:SYSTEM_DEFAULTWORKINGDIRECTORY\PackageDeployer\bin\Release\$PDest\CheckResults

$rulesets = Get-PowerAppsCheckerRulesets -Geography $global:Geography
$rulesetToUse = $rulesets | where Name -EQ "Solution Checker"
$overrides = New-PowerAppsCheckerRuleLevelOverride -Id 'meta-avoid-silverlight' -OverrideLevel High #Use this to Override Rules and set a Higher or Lower Level
$analyzeResult = Invoke-PowerAppsChecker -Geography Australia -ClientApplicationId $aadPowerAppId `
    -TenantId $aadTenant -Ruleset $rulesetToUse -FileUnderAnalysis $env:SYSTEM_DEFAULTWORKINGDIRECTORY\PackageDeployer\bin\Release\$PDest\$PSolution.zip `
    -OutputDirectory $env:SYSTEM_DEFAULTWORKINGDIRECTORY\PackageDeployer\bin\Release\$PDest\CheckResults -ClientApplicationSecret (ConvertTo-SecureString -AsPlainText -Force -String $aadPowerAppSecret) -RuleLevelOverrides $overrides 

Write-Output $analyzeResult.IssueSummary  

if ($analyzeResult.IssueSummary.HighIssueCount -gt 0) {
    $errorCount = $analyzeResult.IssueSummary.HighIssueCount
    $errorMessage = @"
    You have $errorCount High Issues in your Solution    
    You can review the results by getting the output from $env:SYSTEM_DEFAULTWORKINGDIRECTORY\PackageDeployer\bin\Release\$PDest\CheckResults in the Pipeline Artifacts. Results can be analysed using http://sarifviewer.azurewebsites.net/
"@
    Write-Host "##[warning] $errorMessage"
    Write-Host "##vso[task.logissue type=warning;] $errorMessage"    
}

if ($analyzeResult.IssueSummary.CriticalIssueCount -gt 0) {
    $errorCount = $analyzeResult.IssueSummary.CriticalIssueCount
    $errorMessage = @"
    You have $errorCount Critical Issues in your Solution    
    You can review the results by getting the output from $env:SYSTEM_DEFAULTWORKINGDIRECTORY\PackageDeployer\bin\Release\$PDest\CheckResults in the Pipeline Artifacts. Results can be analysed using http://sarifviewer.azurewebsites.net/
"@
    Write-Host "##[error] $errorMessage"
    Write-Host "##vso[task.logissue type=error;] $errorMessage"
    Write-Error $errorMessage
}

    }
Remove-Item nuget.exe
Remove-Item .\Tools -Force -Recurse -ErrorAction Ignore
