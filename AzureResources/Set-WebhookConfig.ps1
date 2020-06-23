Param(
    [string] [Parameter(Mandatory = $true)] $ServerUrl,
    [string] [Parameter(Mandatory = $true)] $UserName,
    [string] [Parameter(Mandatory = $true)] $Password,
	[string] [Parameter(Mandatory = $true)] $WebhookUrl,
	[string] [Parameter(Mandatory = $true)] $WebhookName,
	[string] [Parameter(Mandatory = $true)] $AuthValue
)

	Install-PackageProvider -Name NuGet -Force -Scope CurrentUser
	Install-Module -Name Microsoft.Xrm.Data.PowerShell -Force -Verbose -Scope CurrentUser

	$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
	$Credentials = new-object -typename System.Management.Automation.PSCredential -ArgumentList $UserName, $SecurePassword

	Write-Host $("Connecting to server {0}" -f $ServerUrl)
	$CRMConn = Connect-CrmOnline -Credential $Credentials -ServerUrl $ServerUrl


	#Check if Connection is ready
	if ($false -eq $CRMConn.IsReady) {
		Write-Error "An error occurred: " $CRMConn.LastCrmError
		Write-Error $CRMConn.LastCrmException.Message
		Write-Error $CRMConn.LastCrmException.Source
		Write-Error $CRMConn.LastCrmException.StackTrace
		throw $("Could not establish connection with server {0}" -f $ServerUrl)
	}
	Write-Host $("Connected to CRM organization: {0} - {1}" -f $CRMConn.ConnectedOrgFriendlyName, $CRMConn.ConnectedOrgVersion)
	Write-Output($CRMConn)


function Update-ServiceEndpoint(
    [Microsoft.Xrm.Tooling.Connector.CrmServiceClient] $Conn
){

$fetch=
@"
<fetch version="1.0" output-format="xml-platform" mapping="logical" distinct="false" top="1">
  <entity name="serviceendpoint">
    <attribute name="name" />
    <attribute name="serviceendpointid" />
    <filter type="and">
      <condition attribute="name" operator="eq" value="{$($WebhookName)}" />
    </filter>
  </entity>
</fetch>
"@

$endpoints = Get-CrmRecordsByFetch -conn $Conn -Fetch $fetch 

	        if ($endpoints.CrmRecords.Count -gt 0) {
                Write-Host "Found $($endpoints.CrmRecords.Count) Endpoints"
                $endpoints.CrmRecords | ForEach-Object -Process {
					Write-Host $($WebhookUrl)

					$endpoint = @{}
					$endpoint.Add("url", "https://$($WebhookUrl)")
					$endpoint.Add("authtype", (New-CrmOptionSetValue 4))
					$endpoint.Add("authvalue", $AuthValue)
					Set-CrmRecord -conn $Conn -Fields $endpoint -Id $_.serviceendpointid -EntityLogicalName "serviceendpoint"       
                }
            }
	
}

Update-ServiceEndpoint