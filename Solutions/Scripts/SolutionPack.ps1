& "$env:SYSTEM_DEFAULTWORKINGDIRECTORY/$env:RELEASE_PRIMARYARTIFACTSOURCEALIAS/Solutions/Scripts/_Config.ps1"
& "$env:SYSTEM_DEFAULTWORKINGDIRECTORY/$env:RELEASE_PRIMARYARTIFACTSOURCEALIAS/Solutions/Scripts/_SetupTools.ps1"

##
##Download Package Deployer 
##
./nuget install  Microsoft.CrmSdk.XrmTooling.PackageDeployment.WPF -O .\Tools
$pdFolder = Get-ChildItem ./Tools | Where-Object {$_.Name -match 'Microsoft.CrmSdk.XrmTooling.PackageDeployment.Wpf.'}
md .\Tools\PD
md .\Tools\PD\PkgFolder 
move .\Tools\$pdFolder\tools\*.* .\Tools\PD
Remove-Item .\Tools\$pdFolder -Force -Recurse


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
   Write-Host "Patch found:" $SolutionId "-" $SolutionName "-" $SolutionVersion
   &.\Tools\SolutionPackager.exe /action:pack /folder:..\..\Solutions\packagePatch /zipfile:"..\$global:SolutionName.zip" /packagetype:Both /map:..\map.xml 
}else{
&.\Tools\SolutionPackager.exe /action:pack /folder:..\..\Solutions\packageSolution /zipfile:"..\$global:SolutionName.zip" /packagetype:Both /map:..\map.xml 
}


Remove-Item nuget.exe
Remove-Item .\Tools -Force -Recurse -ErrorAction Ignore
