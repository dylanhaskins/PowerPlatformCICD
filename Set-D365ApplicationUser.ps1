<#
  
  Ensure the following values were created and set by the Provision script

  - d365url - c
  -CompanionAppName / WebhookAppName - name of CompanionApp or Webhook created in Azure
  -d365AppSecurityRoleNames - Security Role

  d365AccessToken will be created by the Get-AccessToken.bat script that should run as first Task in the release
    
  Pass following Script Arguments with a Powershell task in the release

  example for Companion App
  -d365ResourceName "$(d365CrmResourceName)" 
  -servicePrincipalNames "$(CompanionAppName),$(WebhookAppName)" 
  -roleNames "$(d365AppSecurityRoleNames)"

#>


Param(
    , [Parameter(Mandatory = $true)] [string] $d365ResourceName  
    , [Parameter(Mandatory = $true)] [string[]] $servicePrincipalNames
    , [Parameter(Mandatory = $true)] [string] $roleNames
)

$accesstoken=$(az account get-access-token --resource $d365ResourceName --query accessToken --output json)
 
# setting output variables
Write-Host "##vso[task.setvariable variable=accessToken;isOutput=true;issecret=true]$accesstoken"


$lastName = "Account"
$securityRoleNames = $roleNames.Split(',')

# Forcing Tls 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function Get-DefaultBusinessUnit {
    param (
        [string] [Parameter(Mandatory = $true)] $d365ResourceName,
        [string] [Parameter(Mandatory = $true)] $accessToken
    )

    $apiUrl = "$d365ResourceName/api/data/v9.1"

    $response = Invoke-RestMethod `
        -Uri "$apiUrl/businessunits?`$select=businessunitid,name&`$filter=parentbusinessunitid eq null" `
        -Method Get `
        -Headers @{"Authorization" = "Bearer $accessToken"; "Accept" = "application/json"; "OData-MaxVersion" = "4.0"; "OData-Version" = "4.0" }
  
    return $response.value[0].businessunitid
}

function Get-ApplicationUser {
    param (
        [string] [Parameter(Mandatory = $true)] $d365ResourceName,
        [string] [Parameter(Mandatory = $true)] $accessToken,
        [string] [Parameter(Mandatory = $true)] $applicationId,
        [string] [Parameter(Mandatory = $true)] $businessUnitId
    )

    $apiUrl = "$d365ResourceName/api/data/v9.1"

    $headers = @{
        "Authorization"    = "Bearer $accessToken";
        "Accept"           = "application/json";
        "OData-MaxVersion" = "4.0";
        "OData-Version"    = "4.0"
    }

    $response = Invoke-RestMethod `
        -Uri "$apiUrl/systemusers?`$select=systemuserid,applicationid&`$filter=applicationid eq '$applicationId' and businessunitid/businessunitid eq '$businessUnitId'" `
        -Method Get `
        -Headers $headers

    if ($response.value.count -gt 0) {
        return $response.value[0]
    }
}

function New-ApplicationUser {
    param (
        [string] [Parameter(Mandatory = $true)] $d365ResourceName,
        [string] [Parameter(Mandatory = $true)] $accessToken,
        [string] [Parameter(Mandatory = $true)] $applicationId,
        [string] [Parameter(Mandatory = $true)] $firstName,
        [string] [Parameter(Mandatory = $true)] $lastName,
        [string] [Parameter(Mandatory = $true)] $businessUnitId
    )

    $apiUrl = "$d365ResourceName/api/data/v9.1"

    $headers = @{
        "Authorization"    = "Bearer $accessToken";
        "Accept"           = "application/json";
        "OData-MaxVersion" = "4.0";
        "OData-Version"    = "4.0";
        "Prefer"           = "return=representation"
    }    

    $body = @{
        "applicationid"             = "$applicationId";
        "firstname"                 = "$firstName";
        "lastname"                  = "$lastName";
        "internalemailaddress"      = "$applicationId@$($([System.Uri]$d365ResourceName).Host)";
        "businessunitid@odata.bind" = "/businessunits($businessUnitId)"
    }

    $response = Invoke-RestMethod `
        -Uri "$apiUrl/systemusers" `
        -Method Post `
        -Headers $headers `
        -ContentType "application/json" `
        -Body ($body | ConvertTo-Json)
  
    return $response  
}

function Set-ApplicationUser {
    param (
        [string] [Parameter(Mandatory = $true)] $d365ResourceName,
        [string] [Parameter(Mandatory = $true)] $accessToken,
        [string] [Parameter(Mandatory = $true)] $systemUserId,
        [string] [Parameter(Mandatory = $true)] $applicationId,
        [string] [Parameter(Mandatory = $true)] $firstName,
        [string] [Parameter(Mandatory = $true)] $lastName,
        [string] [Parameter(Mandatory = $true)] $businessUnitId
    )

    $apiUrl = "$d365ResourceName/api/data/v9.1"

    $headers = @{
        "Authorization"    = "Bearer $accessToken";
        "Accept"           = "application/json";
        "OData-MaxVersion" = "4.0";
        "OData-Version"    = "4.0";
        "Prefer"           = "return=representation"
    }

    $body = @{
        "applicationid"             = "$applicationId";
        "firstname"                 = "$firstName";
        "lastname"                  = "$lastName";
        "internalemailaddress"      = "$applicationId@$($([System.Uri]$d365ResourceName).Host)";
        "businessunitid@odata.bind" = "/businessunits($businessUnitId)"
    }

    $response = Invoke-RestMethod `
        -Uri "$apiUrl/systemusers($systemUserId)" `
        -Method PATCH `
        -Headers $headers `
        -ContentType "application/json" `
        -Body ($body | ConvertTo-Json)

    return $response;
}

function Get-Role {
    param (
        [string] [Parameter(Mandatory = $true)] $d365ResourceName,
        [string] [Parameter(Mandatory = $true)] $accessToken,
        [string] [Parameter(Mandatory = $true)] $roleName,
        [string] [Parameter(Mandatory = $true)] $businessUnitId
    )

    $apiUrl = "$d365ResourceName/api/data/v9.1"

    $headers = @{
        "Authorization"    = "Bearer $accessToken";
        "Accept"           = "application/json";
        "OData-MaxVersion" = "4.0";
        "OData-Version"    = "4.0"
    }

    $response = Invoke-RestMethod `
        -Uri "$apiUrl/roles?`$select=roleid&`$filter= name eq '$roleName' and businessunitid/businessunitid eq '$businessUnitId'" `
        -Method Get `
        -Headers $headers

    if ($response.value.count -gt 0) {
        return $response.value[0]
    }
}

function Set-ApplicationUserRole {
    param (
        [string] [Parameter(Mandatory = $true)] $d365ResourceName,
        [string] [Parameter(Mandatory = $true)] $accessToken,
        [string] [Parameter(Mandatory = $true)] $systemUserId,
        [string] [Parameter(Mandatory = $true)] $roleId
    )

    $apiUrl = "$d365ResourceName/api/data/v9.1"

    $headers = @{
        "Authorization"    = "Bearer $accessToken";
        "Accept"           = "application/json";
        "OData-MaxVersion" = "4.0";
        "OData-Version"    = "4.0";
    }

    $body = @{
        '@odata.id' = "$apiUrl/roles($roleId)"
    }

    Invoke-RestMethod `
        -Uri "$apiUrl/systemusers($systemUserId)/systemuserroles_association/`$ref" `
        -Method Post `
        -Headers $headers `
        -ContentType "application/json" `
        -Body ($body | ConvertTo-Json) `
    | Out-Null
}

foreach ($servicePrincipalName in $servicePrincipalNames) {
    Write-Host "Checking if the service principal $servicePrincipalName exists..."
    $servicePrincipal = Get-AzADServicePrincipal `
        -DisplayName $servicePrincipalName `
        -ErrorAction SilentlyContinue
    
    if (!$servicePrincipal) {
        Write-Host "##vso[task.logissue type=error;]$servicePrincipalName does not exist."
        return
    }
    
    Write-Host "Checking if the application user $($servicePrincipal.ApplicationId) exists in D365..."
    $businessUnitId = Get-DefaultBusinessUnit `
        -d365ResourceName $d365ResourceName `
        -accessToken $accessToken
    
    $applicationUser = Get-ApplicationUser `
        -d365ResourceName $d365ResourceName `
        -accessToken $accessToken `
        -applicationId $servicePrincipal.ApplicationId `
        -businessUnitId $businessUnitId
    
    if (!$applicationUser) {
        Write-Host "`nCreating application user..."
        Write-Host $businessUnitId
        $applicationUser = New-ApplicationUser `
            -d365ResourceName $d365ResourceName `
            -accessToken $accessToken `
            -applicationId $servicePrincipal.ApplicationId `
            -firstName $servicePrincipalName `
            -lastName $lastName `
            -businessUnitId $businessUnitId
        Write-Host "Application user created..."
    }
    else {
        Write-Host "`nUpdating application user..."
        $applicationUser = Set-ApplicationUser `
            -d365ResourceName $d365ResourceName `
            -accessToken $accessToken `
            -systemUserId $applicationUser.systemuserid `
            -applicationId $servicePrincipal.ApplicationId `
            -firstName $servicePrincipalName `
            -lastName $lastName `
            -businessUnitId $businessUnitId    
        Write-Host "Application user updated..."
    }
    
    foreach ($securityRoleName in $securityRoleNames) {
        Write-Host "`nChecking if the security role $securityRoleName exists..."
        $securityRole = Get-Role `
            -d365ResourceName $d365ResourceName `
            -accessToken $accessToken `
            -roleName $securityRoleName `
            -businessUnitId $businessUnitId
        
        if (!$securityRole) {
            Write-Host "##vso[task.logissue type=error;]$securityRoleName does not exist."
            return
        }
    
        Write-Host "Assigning role $securityRoleName to application user $($servicePrincipal.ApplicationId)..."
        Set-ApplicationUserRole `
            -d365ResourceName $d365ResourceName `
            -accessToken $accessToken `
            -systemUserId $applicationUser.systemuserid `
            -roleId $securityRole.roleid
        Write-Host "Role $securityRoleName assigned to application user $($servicePrincipal.ApplicationId)."
    }    
}
