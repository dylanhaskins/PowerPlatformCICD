Write-Host("Cleaning up Context Files...")

Remove-Item ..\..\..\Entities\Context -Force -Recurse -ErrorAction Ignore
Remove-Item ..\..\..\WebResources\typings\XRM -Force -Recurse -ErrorAction Ignore

New-Item -ItemType Directory -Path ..\..\..\Entities\Context
New-Item -ItemType Directory -Path ..\..\..\WebResources\typings\XRM

if (!$Credentials)
{
	$Credentials = Get-Credential
}
if (!$username)
{
$username =  $Credentials.GetNetworkCredential().UserName
$password =  $Credentials.GetNetworkCredential().Password
}


..\..\XrmContext\XrmContext.exe /url:$global:ServerUrl/XRMServices/2011/Organization.svc /username:$username /password:$password /useconfig /solutions:$global:SolutionName
..\..\XrmDefinitelyTyped\XrmDefinitelyTyped.exe /url:$global:ServerUrl/XRMServices/2011/Organization.svc /username:$username /password:$password /useconfig  