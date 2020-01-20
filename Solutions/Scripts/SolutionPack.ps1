& ((Split-Path $MyInvocation.InvocationName) + "\_Config.ps1")
& ((Split-Path $MyInvocation.InvocationName) + "\_SetupTools.ps1")

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
