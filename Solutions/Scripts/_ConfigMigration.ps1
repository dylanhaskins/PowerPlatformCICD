if (!$ServerUrl) {$ServerUrl = "https://ccmscoredev01.crm6.dynamics.com"}
if (!$Credentials) {$Credentials = Get-Credential}
if (!$conn) {$conn = Connect-CrmOnline -Credential $Credentials -ServerUrl $ServerUrl}

Write-Host "Generating data package"
$packages = Get-CrmDataPackage -Conn $conn -Fetches @("<fetch>
  <entity name='businessunit'>
    <attribute name='businessunitid' />
    <attribute name='name' />
    <attribute name='parentbusinessunitid' />
	<attribute name='description' />
  </entity>
</fetch>") -DisablePluginsGlobally $true `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("")

$packages.Data.InnerXml | Out-File -FilePath  ..\..\ReferenceData\data.xml
$packages.Schema.InnerXml | Out-File -FilePath ..\..\ReferenceData\data_schema.xml



