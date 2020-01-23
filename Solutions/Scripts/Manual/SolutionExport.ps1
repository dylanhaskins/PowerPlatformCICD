######################## SETUP 
& ((Split-Path $MyInvocation.InvocationName) + "\..\_SetupTools.ps1")
& ((Split-Path $MyInvocation.InvocationName) + "\..\_Config.ps1")

######################## GET CONNECTION
if (!$conn)
{
    $conn = Connect-CrmOnlineDiscovery -InteractiveMode
}
Write-Output($conn)

######################## Generate Config Migration data 
#& ((Split-Path $MyInvocation.InvocationName) + "\..\_ConfigMigration.ps1")

######################## Generate Types
Write-Host("Cleaning up Context Files...")
#& ((Split-Path $MyInvocation.InvocationName) + "\..\_GenerateTypes.ps1")

######################## UPDATE VERSION
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
$newVersion = "{0}.{1}.{2}.{3}" -f $theVersion.Major, (Get-Date -UFormat %y%j), $theVersion.Build , (Get-Date -UFormat %H%M)
if ($PatchSolution) {
	$newVersion = "{0}.{1}.{2}.{3}" -f $theVersion.Major, $theVersion.Minor, $theVersion.Build , $theVersion.Revision + 1
}
Set-CrmSolutionVersionNumber -conn $conn -SolutionName  $global:SolutionName -VersionNumber $newVersion



######################## EXPORT SOLUTION
Write-Host "Exporting Unmanaged Solution"
Export-CrmSolution -SolutionName $global:SolutionName -SolutionZipFileName "$global:SolutionName.zip"

Write-Host "Exporting Managed Solution"
Export-CrmSolution -SolutionName $global:SolutionName -Managed -SolutionZipFileName $global:SolutionName"_managed.zip"

######################## EXTRACT SOLUTION

$ErrorActionPreference = "SilentlyContinue"
Remove-Item ..\..\package -Force -Recurse


if ($PatchSolution) {
    &.\Tools\SolutionPackager.exe /action:extract /folder:..\..\package\patch /zipfile:"$global:SolutionName.zip" /packagetype:Both /allowDelete:Yes /c
}else{
    Remove-Item ..\..\package\patch -Force -Recurse
    &.\Tools\SolutionPackager.exe /action:extract /folder:..\..\package\$global:SolutionName /zipfile:"$global:SolutionName.zip" /packagetype:Both /allowDelete:Yes /c
}


