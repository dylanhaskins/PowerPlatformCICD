if (!$ServerUrl) {$ServerUrl = "https://ccmscoredev01.crm6.dynamics.com"}
if (!$Credentials) {$Credentials = Get-Credential}
if (!$conn) {$conn = Connect-CrmOnline -Credential $Credentials -ServerUrl $ServerUrl}

Write-Host "Generating data package"
$packages = Get-CrmDataPackage -Conn $conn -Fetches @("<fetch mapping='logical' version='1.0' output-format='xml-platform' distinct='false'>
  <entity name='businessunit'>
    <attribute name='businessunitid' />
    <attribute name='name' />
    <attribute name='parentbusinessunitid' />
	<attribute name='description' />
	<filter type='and'>
      <condition attribute='name' operator='ne' value='DIA' />
    </filter>
  </entity>
</fetch>") -DisablePluginsGlobally $true `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch mapping='logical' version='1.0' output-format='xml-platform' distinct='false'>
  <entity name='dia_autonumberconfiguration'>
    <attribute name='dia_attributeschemaname' />
    <attribute name='dia_autonumberconfigurationid' />
    <attribute name='dia_description' />
    <attribute name='dia_entityschemaname' />
    <attribute name='dia_name' />
    <attribute name='dia_numberofcharacters' />
    <attribute name='dia_obfuscate' />
    <attribute name='dia_prefix' />
    <attribute name='dia_random' />
    <attribute name='dia_updatekey' />
  </entity>
</fetch>")

$packages.Data.InnerXml | Out-File -FilePath  ..\..\ReferenceData\data.xml
$packages.Schema.InnerXml | Out-File -FilePath ..\..\ReferenceData\data_schema.xml



