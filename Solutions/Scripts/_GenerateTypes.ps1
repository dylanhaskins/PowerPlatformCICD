

if (!$Credentials)
{
	$Credentials = Get-Credential -Message "Credentials : $global:SolutionName @ $global:ServerUrl"
}
if (!$username)
{
	$username =  $Credentials.GetNetworkCredential().UserName
	$password =  $Credentials.GetNetworkCredential().Password
}

if (!$conn) {$conn = Connect-CrmOnline -Credential $Credentials -ServerUrl $global:ServerUrl}

if($conn.IsReady){

$message = "Generating Context and Types from $global:ServerUrl"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.4
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

Write-Host("Cleaning up Context Files...")
#clean up
Remove-Item ..\..\..\Entities\Context -Force -Recurse -ErrorAction Ignore
Remove-Item ..\..\..\WebResources\typings\XRM -Force -Recurse -ErrorAction Ignore

New-Item -ItemType Directory -Path ..\..\..\Entities\Context
New-Item -ItemType Directory -Path ..\..\..\WebResources\typings\XRM

	#generate types
..\..\XrmContext\XrmContext.exe /url:$global:ServerUrl/XRMServices/2011/Organization.svc /username:$username /password:$password /useconfig /out:"../../../Entities/Context"
..\..\XrmDefinitelyTyped\XrmDefinitelyTyped.exe /url:$global:ServerUrl/XRMServices/2011/Organization.svc /username:$username /password:$password /useconfig /out:"../../../Webresources/typings/XRM" /jsLib:"../../../Webresources/src/library"
}