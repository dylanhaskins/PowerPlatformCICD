Write-Host("Exporting Configuration Data...")

if (!$Credentials) {$Credentials = Get-Credential}
if (!$conn) {$conn = Connect-CrmOnline -Credential $Credentials -ServerUrl $global:ServerUrl}

Write-Host "Generating data package"
$packages = Get-CrmDataPackage -Conn $conn -Fetches @("<fetch>
  <entity name='fax'>
    <attribute name='subject' />
    <attribute name='from' />
    <attribute name='to' />
    <attribute name='regardingobjectid' />
    <attribute name='statecode' />
    <attribute name='createdon' />
    <attribute name='activityid' />
    <order attribute='createdon' descending='true' />
    <link-entity name='activityparty' from='activityid' to='activityid' link-type='inner' alias='ab'>
      <filter type='and'>
        <condition attribute='participationtypemask' operator='in'>
          <value>1</value>
          <value>2</value>
          <value>9</value>
        </condition>
        <condition attribute='partyid' operator='eq-userid' />
      </filter>
    </link-entity>
  </entity>
</fetch>") -DisablePluginsGlobally $true #`
#|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("")

$packages.Data.InnerXml | Out-File -FilePath  ..\..\ReferenceData\data.xml
$packages.Schema.InnerXml | Out-File -FilePath ..\..\ReferenceData\data_schema.xml



