######################## SETUP 
$ProgressPreference = 'SilentlyContinue'
. (Join-Path $PSScriptRoot "DeploymentFunctions.ps1")

    #Update Staff ID of Users
    Set-StaffID -Conn $CRMConn

	#Delete False Name Name Type
	Remove-FalseNameType -Conn $CRMConn