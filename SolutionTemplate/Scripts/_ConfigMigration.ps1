$message = "Exporting Configuration Data from $global:ServerUrl"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.3
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId


Write-Host("Exporting Configuration Data...")
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
    <attribute name='statuscode' />
    <attribute name='dia_prefix' />
    <attribute name='dia_random' />
    <attribute name='dia_updatekey' />
  </entity>
</fetch>") `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch mapping='logical' version='1.0' output-format='xml-platform' distinct='false'>
  <entity name='dia_gender'>
    <attribute name='dia_name' />
	<attribute name='dia_gendercode' />
    <attribute name='dia_traveldocumentcode' />
    <attribute name='dia_genderidentitymarker' />
    <attribute name='dia_description' />
    <attribute name='statuscode' />
    <attribute name='dia_dalcode' />
    <attribute name='dia_coscodeformigration' />
    <attribute name='dia_dcscodeformigration' />
    <attribute name='dia_genderid' />
	<attribute name='dia_comments' />
	<attribute name='dia_visibleonportal' />
  </entity>
</fetch>") `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch mapping='logical' version='1.0' output-format='xml-platform' distinct='false'>
  <entity name='dia_country'>
    <attribute name='dia_alternatename1' />
	<attribute name='dia_alternatename2' />
	<attribute name='dia_alternatename3' />
	<attribute name='dia_alternatename4' />
    <attribute name='dia_civilunioncountry' />
    <attribute name='dia_commonwealthcountry' />
	<attribute name='dia_coscodes' />
    <attribute name='dia_countryid' />
    <attribute name='dia_currentbirthcountry' />
    <attribute name='dia_currentcitizenshipcountry' />
    <attribute name='dia_countryvalidfordeliveryaddress' />
    <attribute name='dia_currentpassportcountry' />
	<attribute name='dia_dalcode' />
	<attribute name='dia_dcscodes' />
	<attribute name='dia_historicnames' />
	<attribute name='dia_icaocountrycode' />
    <attribute name='dia_isocode' />
    <attribute name='dia_name' />
	<attribute name='dia_passportsshortname' />
    <attribute name='statecode' />
    <attribute name='statuscode' />
	<attribute name='dia_todayknownas' />
    <attribute name='dia_englishisanofficiallanguage' />
	<attribute name='dia_uncountry' />
    <attribute name='dia_validfromdate' />
    <attribute name='dia_validtodate' />
	<attribute name='dia_visibleonportal' />
  </entity>
</fetch>") `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch mapping='logical' version='1.0' output-format='xml-platform' distinct='false'>
  <entity name='dia_title'>
    <attribute name='statecode' />
    <attribute name='statuscode' />
    <attribute name='dia_titleid' />
    <attribute name='dia_name' />
  </entity>
</fetch>") `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch mapping='logical' version='1.0' output-format='xml-platform' distinct='false'>
  <entity name='dia_nametype'>
    <attribute name='dia_nametypeid' />
    <attribute name='dia_name' />
    <attribute name='dia_nzpolicenametype' />
    <attribute name='dia_dalcode' />
    <attribute name='statuscode' />
    <attribute name='dia_comments' />
    <attribute name='dia_ciqpersonnametype' />
	<attribute name='dia_visibleonportal' />
  </entity>
</fetch>") `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch mapping='logical' version='1.0' output-format='xml-platform' distinct='false'>
  <entity name='dia_documentcategory'>
    <attribute name='dia_name' />
    <attribute name='dia_documentcategoryid' />
    <attribute name='statuscode' />
    <attribute name='statecode' />
  </entity>
</fetch>") `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch mapping='logical' version='1.0' output-format='xml-platform' distinct='false'>
  <entity name='dia_documenttype'>
    <attribute name='dia_documenttypeid' />
    <attribute name='dia_documenttype' />
    <attribute name='statuscode' />
    <attribute name='statecode' />
  </entity>
</fetch>") `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch mapping='logical' version='1.0' output-format='xml-platform' distinct='true'>
  <entity name='dia_documentcategory'>
    <attribute name='dia_documentcategoryid' />
    <link-entity name='dia_dia_documentcategory_dia_documenttype' from='dia_documentcategoryid' to='dia_documentcategoryid' visible='false' intersect='true'>
      <attribute name='dia_documenttypeid' />
    </link-entity>
  </entity>
</fetch>") `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch mapping='logical' version='1.0' output-format='xml-platform' distinct='true'>
  <entity name='dia_configuration'>
	<attribute name='dia_enrcypt' />
	<attribute name='dia_externalconfigurationid' />
	<attribute name='dia_isexternalconfiguration' />
	<attribute name='dia_name' />
    <attribute name='dia_sourceenvironment' />
    <attribute name='statuscode' />
	<attribute name='dia_value' />
	<attribute name='dia_configurationid' />
	  <filter type='and'>
      <condition attribute='dia_sourceenvironment' operator='eq' value='100000001' />
    </filter>
  </entity>
</fetch>") `
 |Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch version='1.0' output-format='xml-platform' mapping='logical' distinct='false'>
  <entity name='territory'>
    <attribute name='name' />
    <attribute name='territoryid' />
  </entity>
</fetch>") `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch mapping='logical' version='1.0' output-format='xml-platform' distinct='false'>
  <entity name='pricelevel'>
    <attribute name='transactioncurrencyid' />
    <attribute name='description' />
    <attribute name='enddate' />
    <attribute name='name' />
    <attribute name='statuscode' />
    <attribute name='pricelevelid' />
    <attribute name='begindate' />
  </entity>
</fetch>") `
 |Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch mapping='logical' version='1.0' output-format='xml-platform' distinct='false'>
  <entity name='team'>
    <attribute name='businessunitid' />
    <attribute name='description' />
    <attribute name='teamid' />
    <attribute name='name' />
    <attribute name='teamtype' />
	 <filter type='and'>
      <condition attribute='teamid' operator='in'>
        <value>{DDB9B2DD-7DCF-E911-A812-000D3A793530}</value>
        <value>{2C2B1234-C6CE-E911-A86C-000D3AE10C61}</value>
	    <value>{6DCCD05B-A1DD-E911-A812-000D3A794E59}</value>
		<value>{36053DA6-A1DD-E911-A812-000D3A794E59}</value>
		<value>{DD610DCB-A1DD-E911-A812-000D3A794E59}</value>
		<value>{2CB5C7E9-A1DD-E911-A812-000D3A794E59}</value>
		<value>{D183D408-A2DD-E911-A812-000D3A794E59}</value>
      </condition>
    </filter>
  </entity>
</fetch>") `
 |Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch version='1.0' output-format='xml-platform' mapping='logical' distinct='false'>
  <entity name='dia_suburblamapping'>
    <attribute name='createdon' />
    <attribute name='dia_suburb' />
    <attribute name='dia_postcode' />
    <attribute name='dia_nzpostward' />
    <attribute name='dia_lacode' />
    <attribute name='dia_aucklandcouncillocalboard' />
    <attribute name='dia_suburblamappingid' />
    <order attribute='dia_suburb' descending='false' />
    <filter type='and'>
      <condition attribute='ownerid' operator='eq' uiname='CCMS CRM Service Account' uitype='systemuser' value='{4AE5DF8C-81A7-E911-A878-000D3AE108A2}' />
    </filter>
  </entity>
</fetch>")


$packages.Data.InnerXml | Out-File -FilePath  (Join-Path $PSScriptRoot "..\ReferenceData\data.xml")
$packages.Schema.InnerXml | Out-File -FilePath (Join-Path $PSScriptRoot "..\ReferenceData\data_schema.xml")
