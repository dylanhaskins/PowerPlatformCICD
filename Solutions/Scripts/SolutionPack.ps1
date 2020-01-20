& ((Split-Path $MyInvocation.InvocationName) + "\_Config.ps1")

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

##
##Download Package Deployer 
##
./nuget install  Microsoft.CrmSdk.XrmTooling.PackageDeployment.WPF -O .\Tools
#$pdFolder = Get-ChildItem ./Tools | Where-Object {$_.Name -match 'Microsoft.CrmSdk.XrmTooling.PackageDeployment.Wpf.'}
#md .\Tools\PD
#move .\Tools\$pdFolder\tools\*.* .\Tools\PD
#Remove-Item .\Tools\$pdFolder -Force -Recurse


&.\Tools\SolutionPackager.exe /action:pack /folder:..\..\Solutions\package /zipfile:"..\$global:UnmanagedPackageFile" /packagetype:Both /map:..\map.xml 

##
##Remove NuGet.exe
##

#Copy-Item .\PkgFolder\ .\Tools\PD -Recurse -Force
#cp .\CCMSPortalDeploymentPackage.dll .\Tools\PD -Force

Remove-Item nuget.exe
Remove-Item .\Tools -Force -Recurse -ErrorAction Ignore
