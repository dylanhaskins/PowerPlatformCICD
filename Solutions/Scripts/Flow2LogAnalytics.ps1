Param(
    [string] [Parameter(Mandatory = $false)] $CustomerID = "",  # Replace with your Workspace ID
    [string] [Parameter(Mandatory = $false)] $SharedKey = "", # Replace with your Primary Key
    [string] [Parameter(Mandatory = $false)] $LogType = "FlowFailures", # Specify the name of the record type that you'll be creating
    [string] [Parameter(Mandatory = $false)] $Username = "",
    [string] [Parameter(Mandatory = $false)] $Password = "",
    [string] [Parameter(Mandatory = $false)] $EnvironmentName = "",
    [int32] [Parameter(Mandatory = $false)] $MinutesSinceLastCheck = 60
)
 
 # Create the function to create the authorization signature
 Function Build-Signature ($customerId, $sharedKey, $date, $contentLength, $method, $contentType, $resource)
 {
     $xHeaders = "x-ms-date:" + $date
     $stringToHash = $method + "`n" + $contentLength + "`n" + $contentType + "`n" + $xHeaders + "`n" + $resource
 
     $bytesToHash = [Text.Encoding]::UTF8.GetBytes($stringToHash)
     $keyBytes = [Convert]::FromBase64String($sharedKey)
 
     $sha256 = New-Object System.Security.Cryptography.HMACSHA256
     $sha256.Key = $keyBytes
     $calculatedHash = $sha256.ComputeHash($bytesToHash)
     $encodedHash = [Convert]::ToBase64String($calculatedHash)
     $authorization = 'SharedKey {0}:{1}' -f $customerId,$encodedHash
     return $authorization
 }
 
 # Create the function to create and post the request
 Function Post-LogAnalyticsData 
 {
     [CmdletBinding()]
     Param(
         [Parameter(ValueFromPipeline)] $bodyJson,
         [string] [Parameter()] $customerId,
         [string] [Parameter()] $sharedKey,
         [string] [Parameter()] $logType
 
     )
     Process {
     Write-Host "Writing FlowRun to Azure Log... Status:" -NoNewline;
     $body = [System.Text.Encoding]::UTF8.GetBytes($bodyJson)
     $method = "POST"
     $contentType = "application/json"
     $resource = "/api/logs"
     $rfc1123date = [DateTime]::UtcNow.ToString("r")
     $contentLength = $body.Length
     $signature = Build-Signature `
         -customerId $customerId `
         -sharedKey $sharedKey `
         -date $rfc1123date `
         -contentLength $contentLength `
         -method $method `
         -contentType $contentType `
         -resource $resource
     $uri = "https://" + $customerId + ".ods.opinsights.azure.com" + $resource + "?api-version=2016-04-01"
 
     $headers = @{
         "Authorization" = $signature;
         "Log-Type" = $logType;
         "x-ms-date" = $rfc1123date;
     }
 
     $response = Invoke-WebRequest -Uri $uri -Method $method -ContentType $contentType -Headers $headers -Body $body -UseBasicParsing
     return $response.StatusCode
 
 }
 }
 
 Install-Module -Name Microsoft.PowerApps.Administration.PowerShell
 Install-Module -Name Microsoft.PowerApps.PowerShell -AllowClobber
 
 $Pass = $Password | ConvertTo-SecureString -AsPlainText -Force
 Add-PowerAppsAccount -Username $Username -Password $Pass

 $Date = (Get-Date).AddMinutes(-$MinutesSinceLastCheck).ToUniversalTime()
 $DateToCheck = Get-Date -Date $Date -Format o
 
 Get-FlowEnvironment | Where-Object {$_.DisplayName -clike "*$EnvironmentName*"} |
 ForEach-Object {Get-AdminFlow -EnvironmentName $_.EnvironmentName | ForEach-Object {$Name = $_.DisplayName; $EnvName = (Get-FlowEnvironment -EnvironmentName $_.EnvironmentName).DisplayName;
 Write-Host "Environment - $EnvName : " -NoNewline; Write-Host "Flow - $Name";   
 Get-FlowRun -EnvironmentName $_.EnvironmentName -FlowName $_.FlowName | 
 Where-Object {$_.Status -like 'Failed' -and $_.StartTime -ge $DateToCheck} | 
 Select-Object @{l="Environment";e={$EnvName}}, @{l="FlowName";e={$Name}}, FlowRunName, Status, StartTime | 
 ConvertTo-Json | Post-LogAnalyticsData -customerId $CustomerID -sharedKey $SharedKey -logType $LogType}}