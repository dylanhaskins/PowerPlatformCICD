
function InstallXrmModule{
$moduleName = "Microsoft.Xrm.Data.Powershell"
$moduleVersion = "2.8.1.3"
if (!(Get-Module -ListAvailable -Name $moduleName )) {
Write-host "Module Not found, installing now"
Install-Module -Name $moduleName -MinimumVersion $moduleVersion -Force -Scope CurrentUser
}
else
{
Write-host "Module Found"
}
}

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

function InstallDevOpsDataModule{
$moduleName = "Microsoft.Xrm.DevOps.Data.Powershell"
$moduleVersion = "1.3.0"
if (!(Get-Module -ListAvailable -Name $moduleName )) {
Write-host "Module Not found, installing now"
Install-Module -Name $moduleName -MinimumVersion $moduleVersion -Force -Scope CurrentUser
}
else
{
Write-host "Module Found"
}
}

Install-PackageProvider -Name NuGet -Force -Scope CurrentUser
InstallXrmModule
InstallToastModule
InstallDevOpsDataModule

$ProgressBar = New-BTProgressBar -Status "Getting Latest SolutionPackager" -Value 0.1
New-BurntToastNotification -Text "CCMS.Core.Solutions" -ProgressBar $ProgressBar -Silent -UniqueIdentifier 'CCMS.Core.Solutions'


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
 
$ServerUrl = "https://ccmsdev02.crm6.dynamics.com"

$ProgressBar = New-BTProgressBar -Status "Getting Credentials for $ServerUrl" -Value 0.15
New-BurntToastNotification -Text "CCMS.Core.Solutions" -ProgressBar $ProgressBar -Silent -UniqueIdentifier 'CCMS.Core.Solutions'

Write-Host "Getting Credentials for $ServerUrl"
$Credentials = Get-Credential
$ProgressBar = New-BTProgressBar -Status "Establishing Connection to CRM Server $ServerUrl" -Value 0.20
New-BurntToastNotification -Text "CCMS.Core.Solutions" -ProgressBar $ProgressBar -Silent -UniqueIdentifier 'CCMS.Core.Solutions'

Write-Host "Establishing Connection to CRM Server $ServerUrl"
$conn = Connect-CrmOnline -Credential $Credentials -ServerUrl $ServerUrl
#$conn = Connect-CrmOnlineDiscovery -InteractiveMode
Write-Output($conn)

$ProgressBar = New-BTProgressBar -Status "Exporting Configuration Data" -Value 0.21
New-BurntToastNotification -Text "CCMS.Core.Solutions" -ProgressBar $ProgressBar -Silent -UniqueIdentifier 'CCMS.Core.Solutions'

& ((Split-Path $MyInvocation.InvocationName) + "\ConfigMigration.ps1")

$ProgressBar = New-BTProgressBar -Status "Generating Context" -Value 0.24
New-BurntToastNotification –Text "CCMS.Core.Solutions" -ProgressBar $ProgressBar -Silent –UniqueIdentifier 'CCMS.Core.Solutions'

& ((Split-Path $MyInvocation.InvocationName) + "\_GenerateTypesAuto.ps1")

$ProgressBar = New-BTProgressBar -Status "Update Solution Version" -Value 0.25
New-BurntToastNotification -Text "CCMS.Core.Solutions" -ProgressBar $ProgressBar -Silent -UniqueIdentifier 'CCMS.Core.Solutions'
#Major.Minor.Build.Revision = TargetProductionDrop.Year+DayofYear.PatchNumber.BuildTime
$SolutionName = "CCMS.Core.SolutionName"
$currentVersion = (Get-CrmRecords -conn $conn -EntityLogicalName solution -FilterAttribute uniquename -FilterOperator "like" -FilterValue $SolutionName -Fields uniquename,publisherid,version).CrmRecords | select version
#Write-Host("Current Version - $currentVersion")
$theVersion = [version]$currentVersion.version
$newVersion = "{0}.{1}.{2}.{3}" -f $theVersion.Major, (Get-Date -UFormat %y%j), $theVersion.Build , (Get-Date -UFormat %H%M)
Set-CrmSolutionVersionNumber -SolutionName $SolutionName -VersionNumber $newVersion -conn $conn

$ProgressBar = New-BTProgressBar -Status "Exporting Unmanaged Solution" -Value 0.30
New-BurntToastNotification -Text "CCMS.Core.Solutions" -ProgressBar $ProgressBar -Silent -UniqueIdentifier 'CCMS.Core.Solutions'

$SearchSoltionName = "CCMS.Core.SolutionName"
$ReturnSolutionName = $SearchSoltionName
$ReturnSolutionVersion = "_1_0_0_0"

# Get parent solution and by name
#$Solutions = Get-CrmRecords -EntityLogicalName solution -conn $conn -Fields 'solutionid','friendlyname','version' -FilterAttribute uniquename -FilterOperator eq -FilterValue $SearchSoltionName
#if ($Solutions.CrmRecords.Count -eq 1) {
#    $ParentSolutionId = $Solutions.CrmRecords[0].solutionid
#    $ReturnSolutionVersion = "_" + $Solutions.CrmRecords[0].version.Replace(".", "_")
#    Write-Host "Found:" $ParentSolutionId "-" $Solutions.CrmRecords[0].friendlyname  "-" $Solutions.CrmRecords[0].version
    # Get most recent patch solution based on created on date
#    $PatchSolutions = Get-CrmRecordsByFetch -Fetch "<fetch><entity name='solution'><attribute name='solutionid' /><attribute name='friendlyname' /><attribute name='version' /><attribute name='uniquename' /><filter><condition attribute='parentsolutionid' operator='eq' value='$parentSolutionId' /></filter><order attribute='createdon' descending='true' /></entity></fetch>" -conn $conn -TopCount 1
#    if ($PatchSolutions.CrmRecords.Count -eq 1) {
#        $ReturnSolutionName = $PatchSolutions.CrmRecords[0].uniquename
#        $ReturnSolutionVersion = "_" + $PatchSolutions.CrmRecords[0].version.Replace(".", "_")
#        Write-Host "Found:" $PatchSolutions.CrmRecords[0].solutionid "-" $ReturnSolutionName "-" $PatchSolutions.CrmRecords[0].version
#    }
#}

Write-Host "Exporting Unmanaged Solution"
Export-CrmSolution -SolutionName $ReturnSolutionName -SolutionZipFileName "$ReturnSolutionName.zip"
$ProgressBar = New-BTProgressBar -Status "Exporting Managed Solution" -Value 0.60
New-BurntToastNotification -Text "CCMS.Core.Solutions" -ProgressBar $ProgressBar -Silent -UniqueIdentifier 'CCMS.Core.Solutions'
Write-Host "Exporting Managed Solution"
Export-CrmSolution -SolutionName $ReturnSolutionName -Managed -SolutionZipFileName $ReturnSolutionName"_managed.zip"
$ProgressBar = New-BTProgressBar -Status "Solution Export Complete" -Value 0.80
New-BurntToastNotification -Text "CCMS.Core.Solutions" -ProgressBar $ProgressBar -Silent -UniqueIdentifier 'CCMS.Core.Solutions'

$ProgressBar = New-BTProgressBar -Status "Unpacking Solution" -Value 0.90
New-BurntToastNotification -Text "CCMS.Core.Solutions" -ProgressBar $ProgressBar -Silent -UniqueIdentifier 'CCMS.Core.Solutions'
Write-Host "Unpacking Solution"

&.\Tools\SolutionPackager.exe /action:extract /folder:..\..\package /zipfile:"$ReturnSolutionName.zip" /packagetype:Both /allowDelete:Yes /c
##
##Remove NuGet.exe
##
Remove-Item nuget.exe
$ProgressBar = New-BTProgressBar -Status "Complete" -Value 1.0
New-BurntToastNotification -Text "CCMS.Core.Solutions" -ProgressBar $ProgressBar -Silent -UniqueIdentifier 'CCMS.Core.Solutions'
