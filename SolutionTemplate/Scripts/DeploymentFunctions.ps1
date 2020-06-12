#region Functions
function Wait-CrmManagementOperation(
    [Int]$SleepDuration = 3
) {
    $completed = $false
    Write-Host "Waiting for completion...$OperationId"

    while ($completed -eq $false) {	
        Start-Sleep -Seconds $SleepDuration
    
        $OpStatus = Get-CrmOperationStatus -ApiUrl $ApiUrl -Credential $Credentials -Id $OperationId

        $OperationStatus = $OpStatus.Status
    
        Write-Host "Status = $OperationStatus"

        if ($OperationStatus -notin "None", "NotStarted", "Ready", "Pending", "Running", "Deleting", "Aborting", "Cancelling") {
            Write-Output($OpStatus)
            $completed = $true
            return
        }
    }
}

function Wait-OrgReady(
    [Int]$SleepDuration = 3
) {
    $completed = $false
    Write-Host "Waiting for org to be ready..."

    while ($completed -eq $false) {	
        #$ResetConn.Dispose()
		
        Start-Sleep -Seconds 60
        $conn2 = Connect-CrmOnline -Credential $Credentials -ServerUrl $ServerUrl 
        #$TargetInstanceIdToReset2 = Get-XrmInstanceByName -ApiUrl $ApiUrl -Cred $Credentials -InstanceName $conn2.ConnectedOrgUniqueName
        Write-Output($conn2)

        if ($conn2.IsReady -eq "True") {
            $completed = $true
            Start-Sleep -Seconds 30
            return
        }
        $conn2.Dispose()
    }
}
function Get-XrmInstanceByName(
    [String]$InstanceName) {
    $instances = Get-CrmInstances -ApiUrl $ApiUrl -Credential $Credentials

    Foreach ($instance in $instances) {
        if ($instance.UniqueName -ieq $InstanceName) {
            Write-Output($instance)
            return
        }
    }
}

function Reset-CRMEnvironment(
    [Microsoft.Xrm.Tooling.Connector.CrmServiceClient] $Conn,
    [bool] $WaitForCompletion
) {
    Install-Module Microsoft.Xrm.OnlineManagementAPI -Force -Scope CurrentUser

    $ApiUrl = "https://admin.services.crm6.dynamics.com"

    $TargetInstanceIdToReset = Get-XrmInstanceByName -ApiUrl $ApiUrl -Cred $Credentials -InstanceName $Conn.ConnectedOrgUniqueName 
			
    if ($null -eq $TargetInstanceIdToReset) {
        throw "$Conn.ConnectedOrgUniqueName not found"
    }	
    Write-Host $("Target Instance Details - {0}" -f $TargetInstanceIdToReset.Id)
						
    $ResetCRMInstance = New-CrmInstanceResetRequestInfo -BaseLanguage 1033 -DomainName $TargetInstanceIdToReset.DomainName -FriendlyName $Conn.ConnectedOrgFriendlyName -CurrencyCode NZD -CurrencyName "New Zealand Dollar" -CurrencyPrecision 2 -CurrencySymbol $ -TemplateList "D365_CustomerService" -TargetReleaseName "Dynamics 365, version 9.0"

    $operation = Reset-CrmInstance -ApiUrl $ApiUrl -Credential $Credentials -TargetInstanceIdToReset $TargetInstanceIdToReset.Id -ResetInstanceRequestDetails $ResetCRMInstance
    $OperationId = $operation.OperationId
    $OperationStatus = $operation.Status

    Write-Output "OperationId = $OperationId"
    Write-Output "Status = $OperationStatus"			

    if ($operation.Errors.Count -gt 0) {
        $errorMessage = $operation.Errors[0].Description
        throw "Errors encountered : $errorMessage"
    }

    if ($WaitForCompletion) {
        $status = Wait-CrmManagementOperation 
        $status
        if ($status.Status -ne "Succeeded") {
            throw "Operation status: $status.Status"
        }
    }
    Wait-OrgReady    
}
function Wait-BulkDeleteOperation
(
    [Microsoft.Xrm.Sdk.Query.QueryByAttribute] $bulkQuery,
    [Microsoft.Xrm.Sdk.EntityCollection] $entityCollection,
    [Int] $operationEndedStatus,
    [Microsoft.Xrm.Tooling.Connector.CrmServiceClient] $Conn
) {
    $createdBulkDeleteOperation = $null
    $ARBITRARY_MAX_POLLING_TIME = 180
    $minutesTicker = $ARBITRARY_MAX_POLLING_TIME

    while ($minutesTicker -gt 0) {
        #Make sure the async operation was retrieved.
        if ($entityCollection.Entities.Count -gt 0) {
            #Grab the one bulk operation that has been created.
            $createdBulkDeleteOperation = $entityCollection.Entities[0]

            #Check the operation's state.
            #NOTE: If a recurrence for the BulkDeleteOperation was
            #specified, the state of the operation will be Suspended,
            #not Completed, since the operation will run again in the
            #future.
            if ($createdBulkDeleteOperation.Attributes["statecode"].Value -ne $operationEndedStatus) {
                #The operation has not yet completed.  Wait a second for
                #the status to change.
                Start-Sleep -Seconds 30                
                $minutesTicker = $minutesTicker - .5
                #Retrieve a fresh version of the bulk delete operation.
                $entityCollection = $Conn.RetrieveMultiple($bulkQuery)
            }
            else {
                #Stop polling as the operation's state is now complete.
                $minutesTicker = 0
                Write-Host "The BulkDeleteOperation record has been retrieved."
               
            }
        }
        else {
            #Wait a second for async operation to activate.
            Start-Sleep -Seconds 1             
            $minutesTicker--
            #Retrieve the entity again.
            $entityCollection = $Conn.RetrieveMultiple($bulkQuery);
        }
    }
    return $createdBulkDeleteOperation
}

function Remove-DefaultSolutions
(
    [Microsoft.Xrm.Tooling.Connector.CrmServiceClient] $Conn
) {
    Write-Host "Fetching solutions to delete" -ForegroundColor Green 
    $fetchxml =
    @"
<fetch>
  <entity name="solution" >
    <attribute name="uniquename" />
    <attribute name="solutionid" />
    <attribute name="friendlyname" />
    <attribute name="installedon" />
    <filter type="or" >
      <condition attribute="uniquename" operator="in" >
            <value>FieldService_anchor</value>
            <value>msdynce_FieldServiceHealth</value>
            <value>FieldServiceUCIAppModule</value>
            <value>FieldServiceAppModule</value>
            <value>FieldService_Patch_8_1</value>
		    <value>msdyn_FieldServiceGeofencing</value>
		    <value>ConnectedFieldService</value>
            <value>FieldService</value>
            <value>IoTProviders</value>
            <value>msdyn_IoTProviders_Patch_1</value>
            <value>msdynce_ServiceLevelAgreementSitemap</value>
            <value>msdyn_ConnectedCustomerServiceHub</value>
            <value>msdyn_ConnectedCustomerService</value>
            <value>msdyn_IoTAssetCommon</value>
            <value>msdyn_IoT_Patch_1</value>   
            <value>IoTConnector</value>	
            <value>msdynce_AutomaticRecordCreationSiteMap</value>	
		    <value>msdynce_3DViewer</value>
            <value>msdynce_CoreServiceScheduling</value>
            <value>msdyn_AnalyticsForCS</value>
            <value>msdynce_CustomerServiceHubPatch</value>
            <value>msdynce_Customerservicehub</value>
            <value>msdynce_CustomerServiceHubAnchor</value>
      </condition>
    </filter>
	<order attribute="installedon" descending="true" />
  </entity>
</fetch>
"@
		
    $solutions = Get-CrmRecordsByFetch -conn $Conn -Fetch $fetchxml
    #Check if any record fetched
    if ($solutions.CrmRecords.Count -gt 0) {
        $solutions.CrmRecords | ForEach-Object -Process {
            #Deleting the solution
            $solutionUniqueName = $_.uniquename
            Write-Host "Deleting solution: $solutionUniqueName" -ForegroundColor Green
           
            $deleteSolutionFilter = New-Object -TypeName Microsoft.Xrm.Sdk.Query.FilterExpression
            $conditionExpression = New-Object -TypeName Microsoft.Xrm.Sdk.Query.ConditionExpression -ArgumentList @("uniquename", [Microsoft.Xrm.Sdk.Query.ConditionOperator]::In, $solutionUniqueName)
            $deleteSolutionFilter.Conditions.Add($conditionExpression)

            $deleteSolutionQuery = New-Object -TypeName Microsoft.Xrm.Sdk.Query.QueryExpression
            $deleteSolutionQuery.EntityName = "solution"
            $deleteSolutionQuery.Distinct = $false
            $deleteSolutionQuery.Criteria = $deleteSolutionFilter
				
            #Create the bulk delete request.
            $bulkDeleteRequest = New-Object -TypeName Microsoft.Crm.Sdk.Messages.BulkDeleteRequest
            $bulkDeleteRequest.JobName = $("Delete Solution:{0}" -f $solutionUniqueName)
            $bulkDeleteRequest.QuerySet = @($deleteSolutionQuery)
            $bulkDeleteRequest.StartDateTime = [datetime]::Now
            $bulkDeleteRequest.ToRecipients = @()
            $bulkDeleteRequest.CCRecipients = @()
            $bulkDeleteRequest.SendEmailNotification = $false
            $bulkDeleteRequest.RecurrencePattern = ""        

            $bulkDeleteResponse = [Microsoft.Crm.Sdk.Messages.BulkDeleteResponse]$Conn.Execute($bulkDeleteRequest)
            $asyncOperationId = $bulkDeleteResponse.JobId;
                

            $bulkQuery = New-Object -TypeName Microsoft.Xrm.Sdk.Query.QueryByAttribute
            $bulkQuery.ColumnSet = New-Object Microsoft.Xrm.Sdk.Query.ColumnSet -ArgumentList $true
            $bulkQuery.EntityName = "bulkdeleteoperation";

            #NOTE: When the bulk delete operation was submitted, the GUID that was
            #returned was the asyncoperationid, not the bulkdeleteoperationid.
            $bulkQuery.Attributes.Add("asyncoperationid");
            $bulkQuery.Values.Add($asyncOperationId);

            #With only the asyncoperationid at this point, a RetrieveMultiple is
            #required to get the bulk delete operation created above.
            $entityCollection = $Conn.RetrieveMultiple($bulkQuery);

            #status complete=3
            $createdBulkDeleteOperation = Wait-BulkDeleteOperation $bulkQuery $entityCollection 3 $Conn

				
            if ($null -eq $createdBulkDeleteOperation -or $createdBulkDeleteOperation.Attributes["statuscode"].Value -ne 30 -or $createdBulkDeleteOperation.Attributes["failurecount"] -gt 0) {					
                throw "Error deleting solution"
            }
            Write-Host $("Solution: {0} deleted" -f $solutionUniqueName)
				
        }
    }
    else {
        Write-Host "No default solutions to delete"
    }
    Write-Host "Delete solutions complete"
}

function Set-SystemSettings
(
    [Microsoft.Xrm.Tooling.Connector.CrmServiceClient] $Conn
) {
    Write-Host "Setting System Settings"
		
    #Fetching Organization entity records and updating the settings
    $orgs = Get-CrmRecords -conn $Conn -EntityLogicalName "organization" -Fields "organizationid", "featureset"

    #Check if any record fetched
    if ($orgs.CrmRecords.Count -gt 0) {
        #Updating settings
        $syssettings = $orgs.CrmRecords[0]

        $updateFields = @{ }
        $updateFields.Add("disablesocialcare", $true)   
        $updateFields.Add("isduplicatedetectionenabled", $false)   
        $updateFields.Add("displaynavigationtour", $false)        
        $updateFields.Add("isauditenabled", $true)
		$updateFields.Add("isuseraccessauditenabled", $true)
		$updateFields.Add("isreadauditenabled", $true)		
        $updateFields.Add("autoapplysla", $false)   
        $updateFields.Add("suppresssla", $false)   
        $updateFields.Add("allowusersseeappdownloadmessage", $false)   
        $updateFields.Add("globalhelpurlenabled", $false)   
        $updateFields.Add("defaultcountrycode", "+64")   
        $updateFields.Add("isdefaultcountrycodecheckenabled", $true)   
        $updateFields.Add("enablebingmapsintegration", $false)   
        $updateFields.Add("isautosaveenabled", $false)   
        $updateFields.Add("plugintracelogsetting", (New-CrmOptionSetValue 2))   
        $updateFields.Add("useskypeprotocol", $false)   
        $updateFields.Add("defaultcrmcustomname", "CCMS Admin (Classic UI)")   			
        $updateFields.Add("localeid", 5129)   # New Zealand
        $updateFields.Add("enablelpauthoring", $false)
        $updateFields.Add("autoapplydefaultoncasecreate", $false)
        $updateFields.Add("autoapplydefaultoncaseupdate", $false)
        $updateFields.Add("enablemicrosoftflowintegration", $false)
        $updateFields.Add("isexternalsearchindexenabled", $true)
		$updateFields.Add("ispresenceenabled", $false)
        $updateFields.Add("allowlegacyclientexperience", $false)
        $updateFields.Add("iscontextualemailenabled", $true)

        if ($null -ne $syssettings.featureset -and $syssettings.featureset.Contains("<name>FCB.GUIDEDHELP</name><value>true</value>")) {
            $updateFields.Add("featureset", $syssettings.featureset.Replace("<name>FCB.GUIDEDHELP</name><value>true</value>", "<name>FCB.GUIDEDHELP</name><value>false</value>"))
        }

        #updating record			
        Set-CrmRecord -conn $Conn -Fields $updateFields -Id $syssettings.organizationid -EntityLogicalName "organization"
    } 

    Write-Host $("Updated CRM System Settings.")
}

function Disable-DefaultViews
(
    [Microsoft.Xrm.Tooling.Connector.CrmServiceClient] $Conn
) {
    Write-Host "Disabling Views" -ForegroundColor Green

    #Fetching and disabling OOTB views
    $fetchxml =
    @"
<fetch>
<entity name="savedquery" >
<attribute name="savedqueryid" />
<attribute name="savedqueryidunique" />
<attribute name="name" />
<filter type="and" >
<condition attribute="ismanaged" operator="eq" value="1" />
<condition attribute="querytype" operator="eq" value="0" />
<condition attribute="statecode" operator="eq" value="0" /> 
<condition attribute="isdefault" operator="eq" value="0" />
<filter type="or" >
<condition attribute="savedqueryid" operator="eq" value="15c63745-0a6e-4322-8416-a62c84d90279" />
<condition attribute="savedqueryid" operator="eq" value="cfbcd7af-aee5-4e45-8ecc-c040d4020581" />
<condition attribute="savedqueryid" operator="eq" value="c147f1f7-1d78-4d10-85bf-7e03b79f74fa" />
<condition attribute="savedqueryid" operator="eq" value="49fb9771-09e1-4e70-b193-198752493577" />
<condition attribute="savedqueryid" operator="eq" value="b18e750a-857b-49c5-8c4e-851ebc857e24" />
<condition attribute="savedqueryid" operator="eq" value="d234426e-1f37-4944-9255-50e19b541c4c" />
<condition attribute="savedqueryid" operator="eq" value="3a3d00e4-ad90-4aa3-b9ab-1e4f82900d29" />
<condition attribute="savedqueryid" operator="eq" value="0a8fa653-4147-4282-bf6b-168cfa839803" />
<condition attribute="savedqueryid" operator="eq" value="927e6cd8-b3ed-4c20-a154-b8bd8a86d172" />
<condition attribute="savedqueryid" operator="eq" value="9818766e-7172-4d59-9279-013835c3decd" />
<condition attribute="savedqueryid" operator="eq" value="9c241a33-ca0b-4e50-ae92-db780d5b2a12" />
<condition attribute="savedqueryid" operator="eq" value="ab582fb0-a846-453e-ad88-77f75ce91264" />
<condition attribute="savedqueryid" operator="eq" value="429bd987-ac6f-df11-986c-00155d2e3002" />
<condition attribute="savedqueryid" operator="eq" value="95aa1763-3800-4d3e-906f-e81b4191ac8e" />
<condition attribute="savedqueryid" operator="eq" value="c111f612-1563-df11-ae90-00155d2e3002" />
<condition attribute="savedqueryid" operator="eq" value="bad2fbea-2673-df11-986c-00155d2e3002" />
<condition attribute="savedqueryid" operator="eq" value="1853caa4-255f-df11-ae90-00155d2e3002" />
<condition attribute="savedqueryid" operator="eq" value="460f1fad-2673-df11-986c-00155d2e3002" />
<condition attribute="savedqueryid" operator="eq" value="4d3297df-c7f0-45f9-9e09-b5b9df223645" />
<condition attribute="savedqueryid" operator="eq" value="6dfba3a1-6df3-4140-831b-b385c7e92b64" />
<condition attribute="savedqueryid" operator="eq" value="2d5e1400-f86d-df11-986c-00155d2e3002" />
<condition attribute="savedqueryid" operator="eq" value="ebd1d24a-eea7-e211-9fb6-00155dd0ea05" />
<condition attribute="savedqueryid" operator="eq" value="6fef1242-d3e2-4358-912d-27c268abd323" />
<condition attribute="savedqueryid" operator="eq" value="fbb9eb64-31d8-4d03-b580-0f22d5a72482" />
</filter> 
</filter>
</entity>
</fetch>
"@
    $systemviews = Get-CrmRecordsByFetch -conn $Conn -Fetch $fetchxml

    #Check if any record fetched
    if ($systemviews.CrmRecords.Count -gt 0) {
        $systemviews.CrmRecords | ForEach-Object -Process {
            #Deactivating the views
            Set-CrmRecordState -conn $Conn -EntityLogicalName savedquery -Id $_.savedqueryid -StateCode 1 -StatusCode 2
        }
    } 
				Write-Host "Disabled CRM Views" -ForegroundColor Green
}

function Disable-DefaultActivityFeeds
(
    [Microsoft.Xrm.Tooling.Connector.CrmServiceClient] $Conn
) {
    Write-Host "Disabling Activity Feeds" -ForegroundColor Green

    #Fetching and disabling OOTB Activity Feeds Configurations
    $fetxml = 
    @"
<fetch>
  <entity name="msdyn_postconfig" >
    <attribute name="statecode" />    
    <attribute name="msdyn_configurewall" />    
    <attribute name="msdyn_postconfigid" />
    <attribute name="msdyn_otc" />    
    <attribute name="statuscode" />    
    <filter type="and" >
      <condition attribute="statecode" operator="eq" value="0" />
    </filter>
  </entity>
</fetch>
"@
    $activityfeedsconfig = Get-CrmRecordsByFetch -conn $Conn -Fetch $fetxml 
    $user = $null
    #Check if any record fetched
    if ($activityfeedsconfig.CrmRecords.Count -gt 0) {
        $activityfeedsconfig.CrmRecords | ForEach-Object -Process {
            #User needs to be the last entity otherwise CRM throws exception
            if ($_.msdyn_otc -eq 8) {
                $user = ($_)          
            }
            else {
                #Updating the "Wall Enabled" config
                $_.msdyn_configurewall = $false
                Set-CrmRecord -conn $Conn -CrmRecord $_
                #Deactivating the config
                Set-CrmRecordState -conn $Conn -EntityLogicalName msdyn_postconfig -Id $_.msdyn_postconfigid -StateCode 1 -StatusCode 2
            }       
        }
        if ($null -ne $user) {
            $user.msdyn_configurewall = $false
            #Updating the "Wall Enabled" config
            Set-CrmRecord -conn $Conn -CrmRecord $user 
            #Deactivating the config
            Set-CrmRecordState -conn $Conn -EntityLogicalName msdyn_postconfig -Id $user.msdyn_postconfigid -StateCode 1 -StatusCode 2
        }
    }
				Write-Host "Disabled Default Activity Feeds Config" -ForegroundColor Green
}

function Update-RootBU
(
    [Microsoft.Xrm.Tooling.Connector.CrmServiceClient] $Conn
) {
    Write-Host "Updating Root Business Unit Name" -ForegroundColor Green

    #Fetching Root Business Unit for renaming
    $fetxml = 
    @"
<fetch>
  <entity name="businessunit">
    <attribute name="name" />
    <attribute name="parentbusinessunitid" />
    <attribute name="businessunitid" />
    <order attribute="name" descending="false" />
    <filter type="and">
      <condition attribute="parentbusinessunitid" operator="null" />
      <condition attribute="isdisabled" operator="eq" value="0" />
    </filter>
  </entity>
</fetch>
"@
    $businessunits = Get-CrmRecordsByFetch -conn $Conn -Fetch $fetxml 		
    #Check if any record fetched
    #If there are more than one root BUs we don't know which one to update
    if ($businessunits.CrmRecords.Count -eq 1) {
        if ($businessunits.CrmRecords[0].name -ne 'DIA') {
            $updateBusinessUnit = @{ }
            $updateBusinessUnit.Add("name", 'DIA')
            #updating record			
            Set-CrmRecord -conn $Conn -Fields $updateBusinessUnit -Id $businessunits.CrmRecords[0].businessunitid -EntityLogicalName "businessunit"
            Write-Host "Updated Root BU Name to DIA" -ForegroundColor Green
        }
    }
				Write-Host "Business Unit Name Update Done" -ForegroundColor Green
}

function Disable-DefaultDocumentTemplates
(
    [Microsoft.Xrm.Tooling.Connector.CrmServiceClient] $Conn
) {
    Write-Host "Disabling default document templates" -ForegroundColor Green	
    #Fetching and disabling Document Templates
    $fetxml = 
    @"
<fetch>
  <entity name="documenttemplate">
		<attribute name="documenttemplateid" />   
    <filter type="and">
      <filter type="or">
        <condition attribute="name" operator="eq" value="Campaign Overview" />
        <condition attribute="name" operator="eq" value="Case SLA Status" />
        <condition attribute="name" operator="eq" value="Case Summary" />
        <condition attribute="name" operator="eq" value="Pipeline Management" />
        <condition attribute="name" operator="eq" value="Account Summary" />
        <condition attribute="name" operator="eq" value="Campaign Summary" />
        <condition attribute="name" operator="eq" value="Case Summary" />
        <condition attribute="name" operator="eq" value="Invoice" />
        <condition attribute="name" operator="eq" value="Invoice Summary" />
        <condition attribute="name" operator="eq" value="Opportunity Summary" />
        <condition attribute="name" operator="eq" value="Order Summary" />
        <condition attribute="name" operator="eq" value="Print quote for customer" />
        <condition attribute="name" operator="eq" value="Quote Summary" />
      </filter>
      <condition attribute="status" operator="ne" value="1" />
    </filter>
  </entity>
</fetch>
"@
    $documentTemplates = Get-CrmRecordsByFetch -conn $Conn -Fetch $fetxml 		
    #Check if any record fetched
    if ($documentTemplates.CrmRecords.Count -gt 0) {
        $documentTemplates.CrmRecords | ForEach-Object -Process {
            #Deactivating the templates
            $doc = @{ }
            $doc.Add("status", $true)
            Set-CrmRecord -conn $Conn -Fields $doc -Id $_.documenttemplateid -EntityLogicalName "documenttemplate"
        }
    } 
				Write-Host "Disabled Default Document Templates" -ForegroundColor Green
}

function Disable-EmailServerProfile
(
    [Microsoft.Xrm.Tooling.Connector.CrmServiceClient] $Conn
) {
    # Fetching and Disabling Email Server Profile
    Write-Host "Disabling Email Server Profile" -ForegroundColor Green
    $fetxml = 
    @"
        <fetch>
         <entity name="emailserverprofile" >
           <attribute name="emailserverprofileid" />
           <attribute name="name" />
           <filter>
             <condition attribute="statecode" operator="eq" value="0" />
           </filter>
         </entity>
        </fetch>
"@
    $emailServerProfile = Get-CrmRecordsByFetch -conn $Conn -Fetch $fetxml 		
    #Check if any record fetched
    if ($emailServerProfile.CrmRecords.Count -gt 0) {
        $emailServerProfile.CrmRecords | ForEach-Object -Process {
            #Deactivating the Email Server Profile
            Set-CrmRecordState -conn $Conn -EntityLogicalName "emailserverprofile" -Id $_.emailserverprofileid -StateCode 1 -StatusCode 2
        }
    } 
    Write-Host "Disabled Email Server Profile" -ForegroundColor Green
}

function Disable-Mailboxes
(
    [Microsoft.Xrm.Tooling.Connector.CrmServiceClient] $Conn
) {
    #Fetching and Disabling Mailboxes
    Write-Host "Disabling Mailboxes" -ForegroundColor Green
    $fetxml = 
    @"
<fetch>
<entity name="mailbox" >
<attribute name="mailboxid" />
<attribute name="name" />
<attribute name="regardingobjectid" />
<filter type="and">
<condition value="0" attribute="statecode" operator="eq" />
<condition attribute="regardingobjectid" operator="not-in">
<value uitype="queue" uiname="Citizenship Office">{E8483702-E687-E911-A85F-000D3A6A0A5E}</value>
<value uitype="queue" uiname="CitList">{0F9F1399-E687-E911-A85F-000D3A6A0A5E}</value>
</condition>
</filter>
</entity>
</fetch>
"@
    $mailBoxes = Get-CrmRecordsByFetch -conn $Conn -Fetch $fetxml 		
    #Check if any record fetched
    if ($mailBoxes.CrmRecords.Count -gt 0) {
        $mailBoxes.CrmRecords | ForEach-Object -Process {
            #Deactivating the mailboxes
            Set-CrmRecordState -conn $Conn -EntityLogicalName "mailbox" -Id $_.mailboxid -StateCode 1 -StatusCode 2
        }
    } 
    Write-Host "Disabled Mailboxes" -ForegroundColor Green
}

function Update-DefaultOptionSets
(
    [Microsoft.Xrm.Tooling.Connector.CrmServiceClient] $Conn
) {
    #Updating Option Set Values
    Write-Host "Deleting optionset values" -ForegroundColor Green 

    Write-Host "Deleting case type values" -ForegroundColor Green 
    $deleteOptionValueRequest = new-object Microsoft.Xrm.Sdk.Messages.DeleteOptionValueRequest
    $deleteOptionValueRequest.AttributeLogicalName = "casetypecode"
    $deleteOptionValueRequest.EntityLogicalName = "incident"
    $deleteOptionValueRequest.Value = 3
    $response = $Conn.ExecuteCrmOrganizationRequest($deleteOptionValueRequest)    

    Write-Host "Deleting case origin values" -ForegroundColor Green 
    $deleteOptionValueRequest = new-object Microsoft.Xrm.Sdk.Messages.DeleteOptionValueRequest
    $deleteOptionValueRequest.OptionSetName = "incident_caseorigincode"	 
    $deleteOptionValueRequest.Value = 2483
    $response = $Conn.ExecuteCrmOrganizationRequest($deleteOptionValueRequest)

    $deleteOptionValueRequest = new-object Microsoft.Xrm.Sdk.Messages.DeleteOptionValueRequest
    $deleteOptionValueRequest.OptionSetName = "incident_caseorigincode"	 
    $deleteOptionValueRequest.Value = 3986
    $response = $Conn.ExecuteCrmOrganizationRequest($deleteOptionValueRequest)

    Write-Host "Deleting case status values" -ForegroundColor Green 
    $deleteOptionValueRequest = new-object Microsoft.Xrm.Sdk.Messages.DeleteOptionValueRequest
    $deleteOptionValueRequest.AttributeLogicalName = "statuscode"
    $deleteOptionValueRequest.EntityLogicalName = "incident"
    $deleteOptionValueRequest.Value = 4
    $response = $Conn.ExecuteCrmOrganizationRequest($deleteOptionValueRequest)

    $deleteOptionValueRequest = new-object Microsoft.Xrm.Sdk.Messages.DeleteOptionValueRequest
    $deleteOptionValueRequest.AttributeLogicalName = "statuscode"
    $deleteOptionValueRequest.EntityLogicalName = "incident" 
    $deleteOptionValueRequest.Value = 1000
    $response = $Conn.ExecuteCrmOrganizationRequest($deleteOptionValueRequest)

    Write-Host "Deleting optionset values finished" -ForegroundColor Green 
}

function Set-StaffID
(
    [Microsoft.Xrm.Tooling.Connector.CrmServiceClient] $Conn
) {
    Write-Host "Updating users to set staff ID" -ForegroundColor Green	
		
    $fetchXml = 
    @"
<fetch>
	<entity name="systemuser">
		<attribute name="systemuserid" />			
		<filter type="and">
			<condition attribute="employeeid" operator="null" />
			<condition attribute="domainname" operator="like" value="%dia.govt.nz" />
			<condition attribute="accessmode" operator="ne" value="4" />
		</filter>
	</entity>
</fetch>
"@

    $users = Get-CrmRecordsByFetch -conn $Conn -Fetch $fetchXml 		
		
    if ($users.CrmRecords.Count -gt 0) {
        $users.CrmRecords | ForEach-Object -Process {
            $user = @{ }
            $user.Add("employeeid", "")
            Set-CrmRecord -conn $Conn -Fields $user -Id $_.systemuserid -EntityLogicalName "systemuser"
        }
    }
    Write-Host "Updating users to set staff ID finished" -ForegroundColor Green
				#Updating users to set staff ID finished
}

function Disable-DefaultProcesses
(
    [Microsoft.Xrm.Tooling.Connector.CrmServiceClient] $Conn
) {   
    #Disabling Default Proccesses
    Write-Host "Disabling Default Processes" -ForegroundColor Green

    $fetchXml = 
    @"
<fetch>
    <entity name="workflow" >
      <attribute name="workflowid" />
      <attribute name="name" />
      <filter type="and" >
        <condition attribute="statecode" operator="eq" value="1" />
        <filter type="or" >
            <condition attribute="workflowid" operator="eq" value="5DE74DCA-CCF3-4179-8C9D-BD7A1BF4C825" />
            <condition attribute="workflowid" operator="eq" value="6E9A821B-3CBC-4F04-9619-F2B723FE4880" />
            <condition attribute="workflowid" operator="eq" value="0FFBCDE4-61C1-4355-AA89-AA1D7B2B8792" />
            <condition attribute="workflowid" operator="eq" value="28920155-1862-4B42-8209-80BCE3694773" />
        </filter>
      </filter>
    </entity>
  </fetch>
"@

    $processes = Get-CrmRecordsByFetch -conn $Conn -Fetch $fetchXml 		
    #Check if any record fetched
    if ($processes.CrmRecords.Count -gt 0) {
        $processes.CrmRecords | ForEach-Object -Process {
            Write-Host $("Disabling {0}" -f $_.name)
            #Deactivating the Processes
            Set-CrmRecordState -conn $Conn -EntityLogicalName "workflow" -Id $_.workflowid -StateCode 0 -StatusCode 1
        }
    }     
}

function Remove-DeprecatedSDKSteps
(
    [Microsoft.Xrm.Tooling.Connector.CrmServiceClient] $Conn
) {
    Write-Host "Removing Deprecated SDK Message Processing Steps" -ForegroundColor Green	
		
    $fetchXml = 
    @"
<fetch>
  <entity name="sdkmessageprocessingstep" >
    <filter type="and" >
      <condition attribute="sdkmessageprocessingstepid" operator="eq" value="531bc267-55af-e911-a886-000d3a6a065c" />
    </filter>
  </entity>
</fetch>
"@

    $sdksteps = Get-CrmRecordsByFetch -conn $Conn -Fetch $fetchXml 		
		
    if ($sdksteps.CrmRecords.Count -gt 0) {
        $sdksteps.CrmRecords | ForEach-Object -Process {
            Remove-CrmRecord -conn $Conn -EntityLogicalName "sdkmessageprocessingstep" -Id $_.sdkmessageprocessingstepid            
        }
    }
    Write-Host "Removing Deprecated SDK Message Processing Steps Finished" -ForegroundColor Green
				#Removing Deprecated SDK Message Processing Steps
}

function Remove-FalseNameType
(
    [Microsoft.Xrm.Tooling.Connector.CrmServiceClient] $Conn
) {
    Write-Host "Removing False Name NameType" -ForegroundColor Green	
		
    $fetchXml = 
    @"
<fetch>
  <entity name="dia_nametype">
    <attribute name="dia_nametypeid" />
    <attribute name="dia_name" />
    <attribute name="createdon" />
    <order attribute="dia_name" descending="false" />
    <filter type="and">
      <condition attribute="dia_nametypeid" operator="eq" uiname="False name" uitype="dia_nametype" value="{9979550F-C4B8-E911-A877-000D3AE10139}" />
    </filter>
  </entity>
</fetch>
"@

    $nametypes = Get-CrmRecordsByFetch -conn $Conn -Fetch $fetchXml 		
		
    if ($nametypes.CrmRecords.Count -gt 0) {
        $nametypes.CrmRecords | ForEach-Object -Process {
            Remove-CrmRecord -conn $Conn -EntityLogicalName "dia_nametype" -Id $_.dia_nametypeid            
        }
    }
    Write-Host "Removing False Name NameType Finished" -ForegroundColor Green
}
				
#endregion

# [bool]$WaitForCompletion = $true
# $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
# $Credentials = new-object -typename System.Management.Automation.PSCredential -ArgumentList $UserName, $SecurePassword

# Write-Host $("Connecting to server {0}" -f $ServerUrl)
# $CRMConn = Connect-CrmOnline -Credential $Credentials -ServerUrl $DeployServerUrl
# #Check if Connection is ready
# if ($false -eq $CRMConn.IsReady) {
#     Write-Error "An error occurred: " $CRMConn.LastCrmError
#     Write-Error $CRMConn.LastCrmException.Message
#     Write-Error $CRMConn.LastCrmException.Source
#     Write-Error $CRMConn.LastCrmException.StackTrace
#     throw $("Could not establish connection with server {0}" -f $ServerUrl)
# }
# Write-Host $("Connected to CRM organization: {0} - {1}" -f $CRMConn.ConnectedOrgFriendlyName, $CRMConn.ConnectedOrgVersion)
# Write-Output($CRMConn)