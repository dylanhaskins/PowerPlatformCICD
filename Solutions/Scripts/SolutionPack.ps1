######################## SETUP 
& "$env:SYSTEM_DEFAULTWORKINGDIRECTORY\Solutions\Scripts\_SetupTools.ps1"
& "$env:SYSTEM_DEFAULTWORKINGDIRECTORY\Solutions\Scripts\_Config.ps1"

InstallCoreTools

# Support for patches
$packageFolder = "packageSolution"
if (Test-Path $env:SYSTEM_DEFAULTWORKINGDIRECTORY\Solutions\packagePatch\Other\Solution.xml) {
    $packageFolder = "packagePatch"
}

&.\Tools\SolutionPackager.exe /action:pack /folder:$env:SYSTEM_DEFAULTWORKINGDIRECTORY\Solutions\$packageFolder /zipfile:"$env:SYSTEM_DEFAULTWORKINGDIRECTORY\PackageDeployer\bin\Release\PkgFolder\$global:SolutionName.zip" /packagetype:Both /map:$env:SYSTEM_DEFAULTWORKINGDIRECTORY\Solutions\map.xml 

Remove-Item nuget.exe
Remove-Item .\Tools -Force -Recurse -ErrorAction Ignore
