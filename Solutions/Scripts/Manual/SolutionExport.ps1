######################## SETUP 
Write-Host "Initialising Setup ...."
. ".\\..\_SetupTools.ps1"
. ".\\..\_Config.ps1"

InstallToastModule
    $message = "Installing Tools..."
    Write-Host $message
    $ProgressBar = New-BTProgressBar -Status $message -Value 0.05
    New-BurntToastNotification -Text $global:SolutionName -ProgressBar $ProgressBar -Silent -UniqueIdentifier $global:SolutionName


InstallXrmDataModule
InstallCoreTools
InstallDevOpsDataModule

######################## GET CONNECTION

if (!$Credentials) {
    $message = "Getting Credentials for $global:ServerUrl"
    Write-Host $message
    $ProgressBar = New-BTProgressBar -Status $message -Value 0.1
    New-BurntToastNotification -Text $global:SolutionName -ProgressBar $ProgressBar -Silent -UniqueIdentifier $global:SolutionName

    $Credentials = Get-Credential
}
if (!$conn) {
    $message = "Establishing connection to $global:ServerUrl"
    Write-Host $message
    $ProgressBar = New-BTProgressBar -Status $message -Value 0.2
    New-BurntToastNotification -Text $global:SolutionName -ProgressBar $ProgressBar -Silent -UniqueIdentifier $global:SolutionName
    $conn = Connect-CrmOnline -Credential $Credentials -ServerUrl $global:ServerUrl
}

Write-Output($conn)

######################## Generate Config Migration data 
$message = "Exporting Configuration Data from $global:ServerUrl"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.3
New-BurntToastNotification -Text $global:SolutionName -ProgressBar $ProgressBar -Silent -UniqueIdentifier $global:SolutionName

& ".\\..\_ConfigMigration.ps1"

######################## Generate Types
Write-Host("Cleaning up Context Files...")
#& ((Split-Path $MyInvocation.InvocationName) + "\..\_GenerateTypes.ps1")

######################## UPDATE VERSION
$message = "Updating Solution version for $global:SolutionName"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.4
New-BurntToastNotification -Text $global:SolutionName -ProgressBar $ProgressBar -Silent -UniqueIdentifier $global:SolutionName

$currentVersion = (Get-CrmRecords -conn $conn -EntityLogicalName solution -FilterAttribute uniquename -FilterOperator "like" -FilterValue $global:SolutionName -Fields uniquename,publisherid,version).CrmRecords | select version
Write-Host("Current Version - $currentVersion")
$theVersion = [version]$currentVersion.version
$newVersion = "{0}.{1}{2}.{3}.{4}" -f $theVersion.Major, (Get-Date -UFormat %y),(Get-Date -UFormat %j).PadLeft(3,'0'), $theVersion.Build , (Get-Date -UFormat %H%M)
Set-CrmSolutionVersionNumber -SolutionName $global:SolutionName -VersionNumber $newVersion -conn $conn
Write-Host("New Version - $newVersion")

######################## CHECK SOLUTION
# Get solution by name
$SolutionQuery = Get-CrmRecords -conn $conn -EntityLogicalName solution -Fields 'friendlyname', 'version' -FilterAttribute uniquename -FilterOperator eq -FilterValue  $global:SolutionName
$Solution = $SolutionQuery.CrmRecords[0]
if (!$Solution) { throw "Solution not found:  $global:SolutionName" }
$SolutionId = $Solution.solutionid
$SolutionVersion = $Solution.version
Write-Host "Found:" $SolutionId "-" $Solution.friendlyname  "-" $SolutionVersion

# Get most recent patch solution
$PatchQuery = Get-CrmRecordsByFetch -conn $conn @"
<fetch>
  <entity name="solution" >
    <attribute name="uniquename" />
    <attribute name="friendlyname" />
    <attribute name="version" />
    <filter>
      <condition attribute="parentsolutionid" operator="eq" value="$SolutionId" />
    </filter>
    <order attribute="createdon" descending="true" />
  </entity>
</fetch>
"@ -TopCount 1
$PatchSolution = $PatchQuery.CrmRecords[0]
if ($PatchSolution) {
    $SolutionId = $PatchSolution.solutionid
    $SolutionName = $PatchSolution.uniquename
    $SolutionVersion = $PatchSolution.version
    Write-Host "Patch found:" $SolutionId "-" $global:SolutionName "-" $SolutionVersion
}

#Major.Minor.Build.Revision = TargetProductionDrop.Year+DayofYear.PatchNumber.BuildTime
$theVersion = [version]$SolutionVersion
$newVersion = "{0}.{1}{2}.{3}.{4}" -f $theVersion.Major, (Get-Date -UFormat %y),(Get-Date -UFormat %j).PadLeft(3,'0'), $theVersion.Build , (Get-Date -UFormat %H%M)
if ($PatchSolution) {
	$newVersion = "{0}.{1}.{2}.{3}" -f $theVersion.Major, $theVersion.Minor, $theVersion.Build , $theVersion.Revision + 1
}
Set-CrmSolutionVersionNumber -conn $conn -SolutionName  $global:SolutionName -VersionNumber $newVersion



######################## EXPORT SOLUTION
$message = "Exporting Unmanaged Solution for $global:SolutionName"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.5
New-BurntToastNotification -Text $global:SolutionName -ProgressBar $ProgressBar -Silent -UniqueIdentifier $global:SolutionName

Export-CrmSolution -SolutionName $global:SolutionName -SolutionZipFileName "$global:SolutionName.zip" -conn $conn

$message = "Exporting Managed Solution for $global:SolutionName"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.6
New-BurntToastNotification -Text $global:SolutionName -ProgressBar $ProgressBar -Silent -UniqueIdentifier $global:SolutionName

Export-CrmSolution -SolutionName $global:SolutionName -Managed -SolutionZipFileName $global:SolutionName"_managed.zip" -conn $conn

######################## EXTRACT SOLUTION

$ErrorActionPreference = "SilentlyContinue"
Remove-Item ..\..\package -Force -Recurse

$message = "Unpacking Solution $global:SolutionName"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.8
New-BurntToastNotification -Text $global:SolutionName -ProgressBar $ProgressBar -Silent -UniqueIdentifier $global:SolutionName

if ($PatchSolution) {
    &.\Tools\SolutionPackager.exe /action:extract /folder:..\..\packagePatch /zipfile:"$global:SolutionName.zip" /packagetype:Both /allowDelete:Yes /c
}else{
    Remove-Item ..\..\package\patch -Force -Recurse
    &.\Tools\SolutionPackager.exe /action:extract /folder:..\..\packageSolution\ /zipfile:"$global:SolutionName.zip" /packagetype:Both /allowDelete:Yes /c
}

$message = "Cleaning Up..."
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 1
New-BurntToastNotification -Text $global:SolutionName -ProgressBar $ProgressBar -Silent -UniqueIdentifier $global:SolutionName

Remove-Item nuget.exe
Remove-Item .\Tools -Force -Recurse -ErrorAction Ignore


