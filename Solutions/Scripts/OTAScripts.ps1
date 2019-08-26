Param(
    [string] [Parameter(Mandatory = $true)] $ServerUrl,
    [string] [Parameter(Mandatory = $true)] $UserName,
    [string] [Parameter(Mandatory = $true)] $Password,
    [boolean] [Parameter(Mandatory = $false)] $PerformReset = $false,
    [boolean] [Parameter(Mandatory = $false)] $PerformOTAs = $false,
    [boolean] [Parameter(Mandatory = $false)] $PerformPostOTAs = $false
)
#Set-ExecutionPolicy –ExecutionPolicy Unrestricted
Install-PackageProvider -Name NuGet -Force -Scope CurrentUser
Install-Module -Name Microsoft.Xrm.Data.PowerShell -Force -Verbose -Scope CurrentUser 

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
        $ResetConn.Dispose()
		
        Start-Sleep -Seconds 300
        $conn2 = Connect-CrmOnline -Credential $Credentials -ServerUrl $ServerUrl 
        #$TargetInstanceIdToReset2 = Get-XrmInstanceByName -ApiUrl $ApiUrl -Cred $Credentials -InstanceName $conn2.ConnectedOrgUniqueName
        Write-Output($conn2)

        if ($conn2.IsReady -eq "True") {
            $completed = $true
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
						
    $ResetCRMInstance = New-CrmInstanceResetRequestInfo -BaseLanguage 1033 -DomainName $TargetInstanceIdToReset.DomainName -FriendlyName $Conn.ConnectedOrgFriendlyName -CurrencyCode NZD -CurrencyName "New Zealand Dollar" -CurrencyPrecision 2 -CurrencySymbol $ -TemplateList "D365_FieldService" -TargetReleaseName "Dynamics 365, version 9.0"

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

[bool]$WaitForCompletion = $true
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

if ($true -eq $PerformReset) {
    Reset-CRMEnvironment -Conn $CRMConn -WaitForCompletion $WaitForCompletion
}

if ($true -eq $PerformOTAs) {
   ##Perform OTAs Here
}
if ($true -eq $PerformPostOTAs) {
	##Perform Post OTAs HEre
}
    
