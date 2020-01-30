#Sample Custom Portal Configuration migration script

Write-Host("Exporting Configuration Data...")

if (!$Credentials) {$Credentials = Get-Credential}
if (!$conn) {$conn = Connect-CrmOnline -Credential $Credentials -ServerUrl $global:ServerUrl}


$packages = Get-CrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_contentsnippet'>
<attribute name='adx_contentsnippetid' />
<attribute name='adx_contentsnippetlanguageid' />
<attribute name='adx_display_name' />
<attribute name='importsequencenumber' />
<attribute name='adx_name' />
<attribute name='statecode' />
<attribute name='statuscode' />
<attribute name='adx_type' />
<attribute name='adx_value' />
<attribute name='adx_websiteid' />
    <filter type='and'>
      <condition attribute='statecode' operator='eq' value='0' />
    </filter>
</entity></fetch>") -DisablePluginsGlobally $true `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_entitypermission'>
<attribute name='adx_accountrelationship' />
<attribute name='adx_append' />
<attribute name='adx_appendto' />
<attribute name='adx_contactrelationship' />
<attribute name='adx_create' />
<attribute name='adx_delete' />
<attribute name='adx_entitylogicalname' />
<attribute name='adx_entitypermissionid' />
<attribute name='importsequencenumber' />
<attribute name='adx_entityname' />
<attribute name='adx_parententitypermission' />
<attribute name='adx_parentrelationship' />
<attribute name='adx_read' />
<attribute name='adx_scope' />
<attribute name='statecode' />
<attribute name='statuscode' />
<attribute name='adx_websiteid' />
<attribute name='adx_write' />
    <filter type='and'>
      <condition attribute='statecode' operator='eq' value='0' />
    </filter>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_entitypermission'>
<attribute name='adx_entitypermissionid' />
<link-entity name='adx_entitypermission_webrole' from='adx_entitypermissionid' to='adx_entitypermissionid' intersect='true' visible='false' >
<attribute name='adx_webroleid' />
</link-entity>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_pagetemplate'>
<attribute name='adx_description' />
<attribute name='adx_entityname' />
<attribute name='importsequencenumber' />
<attribute name='adx_isdefault' />
<attribute name='adx_name' />
<attribute name='adx_pagetemplateid' />
<attribute name='adx_rewriteurl' />
<attribute name='statecode' />
<attribute name='statuscode' />
<attribute name='adx_type' />
<attribute name='adx_usewebsiteheaderandfooter' />
<attribute name='adx_webtemplateid' />
<attribute name='adx_websiteid' />
    <filter type='and'>
      <condition attribute='statecode' operator='eq' value='0' />
    </filter>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_portallanguage'>
<attribute name='adx_description' />
<attribute name='importsequencenumber' />
<attribute name='adx_languagecode' />
<attribute name='adx_lcid' />
<attribute name='adx_name' />
<attribute name='adx_displayname' />
<attribute name='adx_portallanguageid' />
<attribute name='statecode' />
<attribute name='statuscode' />
<attribute name='adx_systemlanguage' />
    <filter type='and'>
      <condition attribute='statecode' operator='eq' value='0' />
    </filter>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_publishingstate'>
<attribute name='adx_displayorder' />
<attribute name='importsequencenumber' />
<attribute name='adx_isdefault' />
<attribute name='adx_name' />
<attribute name='adx_publishingstateid' />
<attribute name='adx_isvisible' />
<attribute name='statecode' />
<attribute name='statuscode' />
<attribute name='adx_websiteid' />
    <filter type='and'>
      <condition attribute='statecode' operator='eq' value='0' />
    </filter>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_publishingstatetransitionrule'>
<attribute name='adx_fromstate_publishingstateid' />
<attribute name='importsequencenumber' />
<attribute name='adx_name' />
<attribute name='adx_publishingstatetransitionruleid' />
<attribute name='statecode' />
<attribute name='statuscode' />
<attribute name='adx_tostate_publishingstateid' />
<attribute name='adx_websiteid' />
    <filter type='and'>
      <condition attribute='statecode' operator='eq' value='0' />
    </filter>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_redirect'>
<attribute name='importsequencenumber' />
<attribute name='adx_inboundurl' />
<attribute name='adx_name' />
<attribute name='adx_redirectid' />
<attribute name='adx_redirecturl' />
<attribute name='adx_sitemarkerid' />
<attribute name='statecode' />
<attribute name='adx_statuscode' />
<attribute name='statuscode' />
<attribute name='adx_webpageid' />
<attribute name='adx_websiteid' />
    <filter type='and'>
      <condition attribute='statecode' operator='eq' value='0' />
    </filter>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_shortcut'>
<attribute name='adx_description' />
<attribute name='adx_disabletargetvalidation' />
<attribute name='adx_displayorder' />
<attribute name='adx_externalurl' />
<attribute name='importsequencenumber' />
<attribute name='adx_name' />
<attribute name='adx_parentpage_webpageid' />
<attribute name='adx_shortcutid' />
<attribute name='statecode' />
<attribute name='statuscode' />
<attribute name='adx_title' />
<attribute name='adx_webfileid' />
<attribute name='adx_webpageid' />
<attribute name='adx_websiteid' />
    <filter type='and'>
      <condition attribute='statecode' operator='eq' value='0' />
    </filter>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_sitemarker'>
<attribute name='importsequencenumber' />
<attribute name='adx_name' />
<attribute name='adx_pageid' />
<attribute name='adx_sitemarkerid' />
<attribute name='statecode' />
<attribute name='statuscode' />
<attribute name='adx_websiteid' />
    <filter type='and'>
      <condition attribute='statecode' operator='eq' value='0' />
    </filter>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_sitesetting'>
<attribute name='adx_description' />
<attribute name='importsequencenumber' />
<attribute name='adx_name' />
<attribute name='adx_sitesettingid' />
<attribute name='statecode' />
<attribute name='statuscode' />
<attribute name='adx_value' />
<attribute name='adx_websiteid' />
    <filter type='and'><condition attribute='statecode' operator='eq' value='0' /></filter>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_weblink'>
<attribute name='adx_description' />
<attribute name='adx_disablepagevalidation' />
<attribute name='adx_displayimageonly' />
<attribute name='adx_displayorder' />
<attribute name='adx_displaypagechildlinks' />
<attribute name='adx_externalurl' />
<attribute name='adx_imagealttext' />
<attribute name='adx_imageheight' />
<attribute name='adx_imageurl' />
<attribute name='adx_imagewidth' />
<attribute name='importsequencenumber' />
<attribute name='adx_name' />
<attribute name='adx_openinnewwindow' />
<attribute name='adx_pageid' />
<attribute name='adx_parentweblinkid' />
<attribute name='adx_publishingstateid' />
<attribute name='adx_robotsfollowlink' />
<attribute name='statecode' />
<attribute name='statuscode' />
<attribute name='adx_weblinkid' />
<attribute name='adx_weblinksetid' />
    <filter type='and'>
      <condition attribute='statecode' operator='eq' value='0' />
    </filter>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_weblinkset'>
<attribute name='adx_copy' />
<attribute name='adx_display_name' />
<attribute name='importsequencenumber' />
<attribute name='adx_name' />
<attribute name='adx_publishingstateid' />
<attribute name='statecode' />
<attribute name='statuscode' />
<attribute name='adx_title' />
<attribute name='adx_weblinksetid' />
<attribute name='adx_websitelanguageid' />
<attribute name='adx_websiteid' />
    <filter type='and'>
      <condition attribute='statecode' operator='eq' value='0' />
    </filter>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_webpage'>
<attribute name='adx_alloworigin' />
<attribute name='adx_authorid' />
<attribute name='adx_category' />
<attribute name='adx_feedbackpolicy' />
<attribute name='adx_copy' />
<attribute name='adx_customcss' />
<attribute name='adx_customjavascript' />
<attribute name='adx_meta_description' />
<attribute name='adx_displaydate' />
<attribute name='adx_displayorder' />
<attribute name='adx_editorialcomments' />
<attribute name='adx_enablerating' />
<attribute name='adx_enabletracking' />
<attribute name='adx_entityform' />
<attribute name='adx_entitylist' />
<attribute name='adx_excludefromsearch' />
<attribute name='adx_expirationdate' />
<attribute name='adx_hiddenfromsitemap' />
<attribute name='adx_image' />
<attribute name='adx_imageurl' />
<attribute name='importsequencenumber' />
<attribute name='adx_isroot' />
<attribute name='adx_masterwebpageid' />
<attribute name='adx_name' />
<attribute name='adx_navigation' />
<attribute name='adx_pagetemplateid' />
<attribute name='adx_parentpageid' />
<attribute name='adx_partialurl' />
<attribute name='adx_publishingstateid' />
<attribute name='adx_releasedate' />
<attribute name='adx_rootwebpageid' />
<attribute name='adx_sharedpageconfiguration' />
<attribute name='statecode' />
<attribute name='statuscode' />
<attribute name='adx_subjectid' />
<attribute name='adx_summary' />
<attribute name='adx_title' />
<attribute name='adx_webform' />
<attribute name='adx_webpageid' />
<attribute name='adx_webpagelanguageid' />
<attribute name='adx_websiteid' />
    <filter type='and'>
      <condition attribute='statecode' operator='eq' value='0' />
    </filter>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_webrole'>
<attribute name='adx_anonymoususersrole' />
<attribute name='adx_authenticatedusersrole' />
<attribute name='adx_description' />
<attribute name='importsequencenumber' />
<attribute name='adx_key' />
<attribute name='adx_name' />
<attribute name='statecode' />
<attribute name='statuscode' />
<attribute name='adx_webroleid' />
<attribute name='adx_websiteid' />
    <filter type='and'>
      <condition attribute='statecode' operator='eq' value='0' />
    </filter>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_webtemplate'>
<attribute name='importsequencenumber' />
<attribute name='adx_mimetype' />
<attribute name='adx_name' />
<attribute name='adx_source' />
<attribute name='statecode' />
<attribute name='statuscode' />
<attribute name='adx_webtemplateid' />
<attribute name='adx_websiteid' />
    <filter type='and'>
      <condition attribute='statecode' operator='eq' value='0' />
    </filter>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_website'>
<attribute name='adx_defaultlanguage' />
<attribute name='adx_footerwebtemplateid' />
<attribute name='adx_headerwebtemplateid' />
<attribute name='importsequencenumber' />
<attribute name='adx_website_language' />
<attribute name='adx_primarydomainname' />
<attribute name='adx_name' />
<attribute name='statecode' />
<attribute name='statuscode' />
<attribute name='adx_websiteid' />
    <filter type='and'>
      <condition attribute='statecode' operator='eq' value='0' />
    </filter>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_websitelanguage'>
<attribute name='importsequencenumber' />
<attribute name='adx_name' />
<attribute name='adx_portallanguageid' />
<attribute name='adx_publishingstate' />
<attribute name='statecode' />
<attribute name='statuscode' />
<attribute name='adx_websiteid' />
<attribute name='adx_websitelanguageid' />
    <filter type='and'>
      <condition attribute='statecode' operator='eq' value='0' />
    </filter>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_webnotificationurl'>
<attribute name='importsequencenumber' />
<attribute name='adx_name' />
<attribute name='statecode' />
<attribute name='statuscode' />
<attribute name='adx_token' />
<attribute name='adx_url' />
<attribute name='adx_webnotificationurlid' />
    <filter type='and'>
      <condition attribute='statecode' operator='eq' value='0' />
    </filter>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_entityform'>
<attribute name='adx_geolocation_addresslinefieldname' />
<attribute name='adx_recordsourceallowcreateonnull' />
<attribute name='adx_redirecturlappendentityidquerystring' />
<attribute name='adx_appendquerystring' />
<attribute name='adx_associatecurrentportaluser' />
<attribute name='adx_attachfile' />
<attribute name='adx_attachfileallowmultiple' />
<attribute name='adx_attachfileacceptextensions' />
<attribute name='adx_attachfilelabel' />
<attribute name='adx_attachfileaccept' />
<attribute name='adx_attachfilerequired' />
<attribute name='adx_attachfilerequirederrormessage' />
<attribute name='adx_attachfilesaveoption' />
<attribute name='adx_attachfilesizeerrormessage' />
<attribute name='adx_attachfilestoragelocation' />
<attribute name='adx_attachfiletypeerrormessage' />
<attribute name='adx_redirecturlquerystringattribute' />
<attribute name='adx_autogeneratesteps' />
<attribute name='adx_captcharequired' />
<attribute name='adx_geolocation_cityfieldname' />
<attribute name='adx_geolocation_countryfieldname' />
<attribute name='adx_geolocation_countyfieldname' />
<attribute name='adx_registerstartupscript' />
<attribute name='adx_redirecturlcustomquerystring' />
<attribute name='adx_geolocation_displaymap' />
<attribute name='adx_entitypermissionsenabled' />
<attribute name='adx_validationsummarylinksenabled' />
<attribute name='adx_geolocation_enabled' />
<attribute name='adx_entityformid' />
<attribute name='adx_entityname' />
<attribute name='adx_entitysourcetype' />
<attribute name='adx_formname' />
<attribute name='adx_geolocation_formattedaddressfieldname' />
<attribute name='adx_hideformonsuccess' />
<attribute name='importsequencenumber' />
<attribute name='adx_instructions' />
<attribute name='adx_portaluserlookupattributeisactivityparty' />
<attribute name='adx_geolocation_latitudefieldname' />
<attribute name='adx_geolocation_longitudefieldname' />
<attribute name='adx_forceallfieldsrequired' />
<attribute name='adx_geolocation_maptype' />
<attribute name='adx_attachfilemaxsize' />
<attribute name='adx_mode' />
<attribute name='adx_name' />
<attribute name='adx_geolocation_neighborhoodfieldname' />
<attribute name='adx_nextbuttoncssclass' />
<attribute name='adx_nextbuttontext' />
<attribute name='adx_onsuccess' />
<attribute name='organizationid' />
<attribute name='adx_populatereferenceentitylookupfield' />
<attribute name='adx_previousbuttoncssclass' />
<attribute name='adx_previousbuttontext' />
<attribute name='adx_primarykeyname' />
<attribute name='adx_provisionedlanguages' />
<attribute name='adx_redirecturlquerystringattributeparamname' />
<attribute name='adx_recommendedfieldsrequired' />
<attribute name='adx_recordidquerystringparametername' />
<attribute name='adx_recordnotfoundmessage' />
<attribute name='adx_recordsourceentitylogicalname' />
<attribute name='adx_referencerecordsourcerelationshipname' />
<attribute name='adx_redirecturl' />
<attribute name='adx_redirecturlquerystringname' />
<attribute name='adx_redirectwebpage' />
<attribute name='adx_referenceentitylogicalname' />
<attribute name='adx_referenceentityprimarykeylogicalname' />
<attribute name='adx_referenceentityreadonlyformname' />
<attribute name='adx_referenceentityrelationshipname' />
<attribute name='adx_referenceentitysourcetype' />
<attribute name='adx_referencequeryattributelogicalname' />
<attribute name='adx_referencequerystringisprimarykey' />
<attribute name='adx_referencequerystringname' />
<attribute name='adx_referencetargetlookupattributelogicalname' />
<attribute name='adx_recordsourcerelationshipname' />
<attribute name='adx_renderwebresourcesinline' />
<attribute name='adx_attachfilerestrictaccept' />
<attribute name='adx_setentityreference' />
<attribute name='adx_settings' />
<attribute name='adx_showcaptchaforauthenticatedusers' />
<attribute name='adx_showownerfields' />
<attribute name='adx_referenceentityshowreadonlyform' />
<attribute name='adx_showunsupportedfields' />
<attribute name='adx_geolocation_statefieldname' />
<attribute name='statecode' />
<attribute name='statuscode' />
<attribute name='adx_submitbuttonbusytext' />
<attribute name='adx_submitbuttoncssclass' />
<attribute name='adx_submitbuttontext' />
<attribute name='adx_successmessage' />
<attribute name='adx_tabname' />
<attribute name='adx_targetentityportaluserlookupattribute' />
<attribute name='adx_tooltipenabled' />
<attribute name='adx_validationgroup' />
<attribute name='adx_validationsummarycssclass' />
<attribute name='adx_validationsummaryheadertext' />
<attribute name='adx_validationsummarylinktext' />
<attribute name='adx_websiteid' />
<attribute name='adx_geolocation_postalcodefieldname' />
    <filter type='and'>
      <condition attribute='statecode' operator='eq' value='0' />
    </filter>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_entityformmetadata'>
<attribute name='adx_adddescription' />
<attribute name='adx_attributelogicalname' />
<attribute name='adx_constantsummaximumtotal' />
<attribute name='adx_constantsumminimumtotal' />
<attribute name='adx_constantsumvalidationerrormessage' />
<attribute name='adx_controlstyle' />
<attribute name='adx_cssclass' />
<attribute name='adx_description' />
<attribute name='adx_entityform' />
<attribute name='adx_entityformforcreate' />
<attribute name='adx_entityformmetadataid' />
<attribute name='adx_fieldisrequired' />
<attribute name='adx_geolocationvalidatorerrormessage' />
<attribute name='adx_groupname' />
<attribute name='adx_ignoredefaultvalue' />
<attribute name='importsequencenumber' />
<attribute name='adx_label' />
<attribute name='adx_maxmultiplechoiceselectedcount' />
<attribute name='adx_minmultiplechoiceselectedcount' />
<attribute name='adx_multiplechoicevalidationerrormessage' />
<attribute name='adx_name' />
<attribute name='adx_notes_settings' />
<attribute name='adx_onsavefromattribute' />
<attribute name='adx_onsavetype' />
<attribute name='adx_descriptionposition' />
<attribute name='adx_prepopulatefromattribute' />
<attribute name='adx_prepopulatetype' />
<attribute name='adx_prepopulatevalue' />
<attribute name='adx_provisionedlanguages' />
<attribute name='adx_randomizeoptionsetvalues' />
<attribute name='adx_rangevalidationerrormessage' />
<attribute name='adx_rankordernotiesvalidationerrormessage' />
<attribute name='adx_validationregularexpressionerrormessage' />
<attribute name='adx_requiredfieldvalidationerrormessage' />
<attribute name='adx_sectionname' />
<attribute name='adx_setvalueonsave' />
<attribute name='statecode' />
<attribute name='statuscode' />
<attribute name='adx_subgrid_name' />
<attribute name='adx_subgrid_settings' />
<attribute name='adx_tabname' />
<attribute name='adx_timeline_settings' />
<attribute name='adx_type' />
<attribute name='adx_useattributedescriptionproperty' />
<attribute name='adx_validationerrormessage' />
<attribute name='adx_validationregularexpression' />
<attribute name='adx_onsavevalue' />
    <filter type='and'>
      <condition attribute='statecode' operator='eq' value='0' />
    </filter>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_entitylist'>
<attribute name='adx_filter_applybuttonlabel' />
<attribute name='adx_calendar_initialdate' />
<attribute name='adx_calendar_initialview' />
<attribute name='adx_calendar_style' />
<attribute name='adx_calendar_enabled' />
<attribute name='adx_createbuttonlabel' />
<attribute name='adx_map_credentials' />
<attribute name='adx_registerstartupscript' />
<attribute name='adx_calendar_descriptionfieldname' />
<attribute name='adx_detailsbuttonlabel' />
<attribute name='adx_calendar_timezone' />
<attribute name='adx_map_distanceunits' />
<attribute name='adx_map_distancevalues' />
<attribute name='adx_emptylisttext' />
<attribute name='adx_entitypermissionsenabled' />
<attribute name='adx_calendar_enddatefieldname' />
<attribute name='adx_entitylistid' />
<attribute name='adx_entityname' />
<attribute name='adx_filteraccount' />
<attribute name='adx_filter_definition' />
<attribute name='adx_filter_enabled' />
<attribute name='adx_filter_orientation' />
<attribute name='adx_filterportaluser' />
<attribute name='adx_filterwebsite' />
<attribute name='adx_idquerystringparametername' />
<attribute name='importsequencenumber' />
<attribute name='adx_map_infoboxdescriptionfieldname' />
<attribute name='adx_map_infoboxoffsetx' />
<attribute name='adx_map_infoboxoffsety' />
<attribute name='adx_map_infoboxtitlefieldname' />
<attribute name='adx_calendar_alldayfieldname' />
<attribute name='adx_key' />
<attribute name='adx_map_latitude' />
<attribute name='adx_map_latitudefieldname' />
<attribute name='adx_calendar_locationfieldname' />
<attribute name='adx_map_longitude' />
<attribute name='adx_map_longitudefieldname' />
<attribute name='adx_map_enabled' />
<attribute name='adx_map_type' />
<attribute name='adx_name' />
<attribute name='adx_odata_enabled' />
<attribute name='adx_odata_entitysetname' />
<attribute name='adx_odata_entitytypename' />
<attribute name='adx_odata_view' />
<attribute name='organizationid' />
<attribute name='adx_calendar_organizerfieldname' />
<attribute name='adx_pagesize' />
<attribute name='adx_map_pushpinheight' />
<attribute name='adx_map_pushpinurl' />
<attribute name='adx_map_pushpinwidth' />
<attribute name='adx_primarykeyname' />
<attribute name='adx_provisionedlanguages' />
<attribute name='adx_map_resturl' />
<attribute name='adx_searchenabled' />
<attribute name='adx_searchplaceholdertext' />
<attribute name='adx_searchtooltiptext' />
<attribute name='adx_settings' />
<attribute name='adx_calendar_startdatefieldname' />
<attribute name='statecode' />
<attribute name='statuscode' />
<attribute name='adx_calendar_summaryfieldname' />
<attribute name='adx_calendar_timezonemode' />
<attribute name='adx_view' />
<attribute name='adx_views' />
<attribute name='adx_webpageforcreate' />
<attribute name='adx_webpagefordetailsview' />
<attribute name='adx_websiteid' />
<attribute name='adx_map_zoom' />
    <filter type='and'>
      <condition attribute='statecode' operator='eq' value='0' />
    </filter>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='adx_webfile'>
<attribute name='adx_alloworigin' />
<attribute name='adx_contentdisposition' />
<attribute name='adx_displayorder' />
<attribute name='adx_excludefromsearch' />
<attribute name='adx_hiddenfromsitemap' />
<attribute name='importsequencenumber' />
<attribute name='adx_masterwebfileid' />
<attribute name='adx_name' />
<attribute name='adx_parentpageid' />
<attribute name='adx_partialurl' />
<attribute name='adx_publishingstateid' />
<attribute name='adx_releasedate' />
<attribute name='statecode' />
<attribute name='statuscode' />
<attribute name='adx_subjectid' />
<attribute name='adx_summary' />
<attribute name='adx_title' />
<attribute name='adx_webfileid' />
<attribute name='adx_websiteid' />
      <filter type='and'>
        <condition attribute='statecode' operator='eq' value='0' />
      </filter>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch><entity name='annotation'>
<attribute name='notetext' />
<attribute name='documentbody' />
<attribute name='filename' />
<attribute name='filesize' />
<attribute name='importsequencenumber' />
<attribute name='isdocument' />
<attribute name='langid' />
<attribute name='mimetype' />
<attribute name='annotationid' />
<attribute name='objecttypecode' />
<attribute name='objectid' />
<attribute name='stepid' />
<attribute name='subject' />
    <link-entity name='adx_webfile' from='adx_webfileid' to='objectid' link-type='inner' alias='ab'>
      <filter type='and'>
        <condition attribute='statecode' operator='eq' value='0' />
      </filter>
    </link-entity>
</entity></fetch>") -DisablePluginsGlobally $true  `
|Add-FetchesToCrmDataPackage -Conn $conn -Fetches @("<fetch>
<entity name='adx_webpageaccesscontrolrule' >
   <attribute name='adx_webpageid' />
	<attribute name='adx_webpageaccesscontrolruleid' />
	 <attribute name='adx_websiteid' />
	  <attribute name='adx_scope' />
	   <attribute name='adx_right' />
		<attribute name='adx_name' />
		 <attribute name='adx_description' />
	<filter type='and'>
      <condition attribute='adx_right' operator='eq' value='2' />
    </filter>
</entity>
</fetch>") -DisablePluginsGlobally $true 

$packages.Data.InnerXml | Out-File -FilePath  ..\..\ReferenceData\data.xml
$packages.Schema.InnerXml | Out-File -FilePath ..\..\ReferenceData\data_schema.xml


