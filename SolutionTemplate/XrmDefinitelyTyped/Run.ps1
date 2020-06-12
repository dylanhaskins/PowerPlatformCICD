
######################## SETUP 
. ((Split-Path $MyInvocation.InvocationName) + ".\..\Solutions\Scripts\_Config.ps1")


Write-Host("Cleaning up Context Files...")
#clean up
Remove-Item ..\WebResources\typings\XRM -Force -Recurse -ErrorAction Ignore

New-Item -ItemType Directory -Path ..\WebResources\typings\XRM

if (!$Credentials)
{
	$Credentials = Get-Credential
}
if (!$username)
{
	$username =  $Credentials.GetNetworkCredential().UserName
	$password =  $Credentials.GetNetworkCredential().Password
}

.\XrmDefinitelyTyped.exe  /url:$global:ServerUrl/XRMServices/2011/Organization.svc /username:$username /password:$password /useconfig /out:"../Webresources/typings/XRM" /jsLib:"../Webresources/src/library"