
$sourceNugetExe = "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe"
$targetNugetExe = ".\nuget.exe"
Remove-Item .\Tools -Force -Recurse -ErrorAction Ignore
Invoke-WebRequest $sourceNugetExe -OutFile $targetNugetExe
Set-Alias nuget $targetNugetExe -Scope Global -Verbose

##
##Download CoreTools
##
./nuget install  Microsoft.CrmSdk.CoreTools -O .\Tools
$coreToolsFolder = Get-ChildItem ./Tools | Where-Object {$_.Name -match 'Microsoft.CrmSdk.CoreTools.'}
move .\Tools\$coreToolsFolder\content\bin\coretools\*.* .\Tools\
Remove-Item .\Tools\$coreToolsFolder -Force -Recurse

# Support for patches
$packageFolder = "packageSolution"
if (Test-Path $env:SYSTEM_DEFAULTWORKINGDIRECTORY\Solutions\packagePatch\Other\Solution.xml) {
    $packageFolder = "packagePatch"
}


&.\Tools\SolutionPackager.exe /action:pack /folder:$env:SYSTEM_DEFAULTWORKINGDIRECTORY\Solutions\$packageFolder /zipfile:"$env:SYSTEM_DEFAULTWORKINGDIRECTORY\PackageDeployer\bin\Release\PkgFolder\$global:SolutionName.zip" /packagetype:Both /map:$env:SYSTEM_DEFAULTWORKINGDIRECTORY\Solutions\map.xml 

Remove-Item nuget.exe
Remove-Item .\Tools -Force -Recurse -ErrorAction Ignore
