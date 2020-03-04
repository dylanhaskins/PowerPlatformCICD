if (!$Credentials)
{
	$Credentials = Get-Credential
}
if (!$username)
{
$username =  $Credentials.GetNetworkCredential().UserName
$password =  $Credentials.GetNetworkCredential().Password
}

.\XrmContext.exe /username:$username /password:$password /useconfig