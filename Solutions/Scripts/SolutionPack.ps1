& ((Split-Path $MyInvocation.InvocationName) + "\_Config.ps1")
& ((Split-Path $MyInvocation.InvocationName) + "\_SetupTools.ps1")

##
##Download Package Deployer 
##
./nuget install  Microsoft.CrmSdk.XrmTooling.PackageDeployment.WPF -O .\Tools
$pdFolder = Get-ChildItem ./Tools | Where-Object {$_.Name -match 'Microsoft.CrmSdk.XrmTooling.PackageDeployment.Wpf.'}
md .\Tools\PD
md .\Tools\PD\PkgFolder 
move .\Tools\$pdFolder\tools\*.* .\Tools\PD
Remove-Item .\Tools\$pdFolder -Force -Recurse


if (Test-Path ...\..\Solutions\package\patch\Other\Solution.xml) {
    &.\Tools\SolutionPackager.exe /action:pack /folder:..\..\Solutions\package\patch /zipfile:"..\$global:SolutionName.zip" /packagetype:Both /map:..\map.xml 
}else{
    &.\Tools\SolutionPackager.exe /action:pack /folder:..\..\Solutions\package\$global:SolutionName /zipfile:"..\$global:SolutionName.zip" /packagetype:Both /map:..\map.xml 
}

Remove-Item nuget.exe
Remove-Item .\Tools -Force -Recurse -ErrorAction Ignore
