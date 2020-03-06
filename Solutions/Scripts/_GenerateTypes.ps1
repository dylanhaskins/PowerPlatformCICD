

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
Remove-Item (Join-Path $PSScriptRoot "..\..\Entities\Context") -Force -Recurse -ErrorAction Ignore
Remove-Item (Join-Path $PSScriptRoot "..\..\WebResources\typings\XRM") -Force -Recurse -ErrorAction Ignore

New-Item -ItemType Directory -Path (Join-Path $PSScriptRoot "..\..\Entities\Context")
New-Item -ItemType Directory -Path (Join-Path $PSScriptRoot  "..\..\WebResources\typings\XRM")

	#generate types
$CurrentLocation = Get-Location
Set-Location -Path (Join-Path $PSScriptRoot "..\XrmContext")
. .\XrmContext.exe /url:$global:ServerUrl/XRMServices/2011/Organization.svc /username:$username /password:$password /useconfig /out:"../../Entities/Context"
Set-Location -Path (Join-Path $PSScriptRoot "..\XrmDefinitelyTyped")
. .\XrmDefinitelyTyped.exe /url:$global:ServerUrl/XRMServices/2011/Organization.svc /username:$username /password:$password /useconfig /out:"../../Webresources/typings/XRM" /jsLib:"../../Webresources/src/library"
Set-Location -Path $CurrentLocation
}