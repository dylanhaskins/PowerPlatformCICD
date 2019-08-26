
Function InstallToastModule{
$moduleName = "BurntToast"
if (!(Get-Module -ListAvailable -Name $moduleName )) {
Write-host "Module Not found, installing now"
Install-Module -Name $moduleName -Force -Scope CurrentUser
}
else
{
Write-host "Module Found"
}
}

InstallToastModule

$ProgressBar = New-BTProgressBar -Status "Getting Latest PackageDeployer" -Value 0.2
New-BurntToastNotification -Text "CCMS.Core.PackageDeployer" -ProgressBar $ProgressBar -Silent -UniqueIdentifier 'CCMS.Core.PackageDeployer'

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
$pdFolder = Get-ChildItem ./Tools | Where-Object {$_.Name -match 'Microsoft.CrmSdk.XrmTooling.PackageDeployment.Wpf.'}
md .\Tools\PD
md .\Tools\PD\PkgFolder 
move .\Tools\$pdFolder\tools\*.* .\Tools\PD
Remove-Item .\Tools\$pdFolder -Force -Recurse

##
## Solution pack
##
$ProgressBar = New-BTProgressBar -Status "Packing Solution" -Value 0.5
New-BurntToastNotification -Text "CCMS.Core.PackageDeployer" -ProgressBar $ProgressBar -Silent -UniqueIdentifier 'CCMS.Core.PackageDeployer'

&.\Tools\SolutionPackager.exe /action:pack /folder:..\..\..\Solutions\package /zipfile:".\PkgFolder\ImportFiles\CCMSCore.zip" /packagetype:Both /map:..\..\..\Solutions\map.xml 


Copy-Item .\PkgFolder\ .\Tools\PD -Recurse -Force
cp .\CCMS*.dll .\Tools\PD -Force

##
##Remove NuGet.exe
##
Remove-Item nuget.exe
$ProgressBar = New-BTProgressBar -Status "Complete" -Value 1.0
New-BurntToastNotification -Text "CCMS.Core.PackageDeployer" -ProgressBar $ProgressBar -Silent -UniqueIdentifier 'CCMS.Core.PackageDeployer'
