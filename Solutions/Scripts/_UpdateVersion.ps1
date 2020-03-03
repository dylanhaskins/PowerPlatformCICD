
if (!$Credentials) {$Credentials = Get-Credential -Message "Credentials : $global:SolutionName @ $global:ServerUrl"}
if (!$conn) {$conn = Connect-CrmOnline -Credential $Credentials -ServerUrl $global:ServerUrl}

if($conn.IsReady){
$message = "Updating Solution version for $global:SolutionName"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.5
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

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

}
