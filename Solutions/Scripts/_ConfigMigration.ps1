

if (!$Credentials) {$Credentials = Get-Credential -Message "Credentials : $global:SolutionName @ $global:ServerUrl"}
if (!$conn) {$conn = Connect-CrmOnline -Credential $Credentials -ServerUrl $global:ServerUrl}

if($conn.IsReady){


$message = "Exporting Configuration Data from $global:ServerUrl"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.3
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId


Write-Host("Exporting Configuration Data...")
Write-Host "Generating data package"
$packages = Get-CrmDataPackage -Conn $conn -Fetches @("<fetch>
  <entity name='theme'>
    <attribute name='themeid' />
    <attribute name='name' />
    <attribute name='type' />
    <attribute name='isdefaulttheme' />
    <order attribute='name' descending='false' />
    <filter type='and'>
      <condition attribute='name' operator='eq' value='CRM Blue Theme' />
    </filter>
  </entity>
</fetch>") -DisablePluginsGlobally $true #`
#|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("")


$packages.Data.InnerXml | Out-File -FilePath  (Join-Path $PSScriptRoot "..\ReferenceData\data.xml")
$packages.Schema.InnerXml | Out-File -FilePath (Join-Path $PSScriptRoot "..\ReferenceData\data_schema.xml")
}
