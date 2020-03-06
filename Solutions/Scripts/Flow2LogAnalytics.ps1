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
 Function Post-LogAnalyticsData($customerId, $sharedKey, $body, $logType)
 {

     Write-Host "Writing FlowRun to Azure Log... Status:" -NoNewline;
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
     Write-Host $response.StatusCode
     return $response.StatusCode
 }
 
 Install-Module -Name Microsoft.PowerApps.Administration.PowerShell
 Install-Module -Name Microsoft.PowerApps.PowerShell -AllowClobber
 
 $Pass = $Password | ConvertTo-SecureString -AsPlainText -Force
 Add-PowerAppsAccount -Username $Username -Password $Pass

 $Date = (Get-Date).AddMinutes(-$MinutesSinceLastCheck).ToUniversalTime()
 $DateToCheck = Get-Date -Date $Date -Format o

 $ProgressPreference = 'SilentlyContinue' 
 
$all = (Measure-Command { 
    foreach ($environment in (Get-FlowEnvironment *$EnvironmentName* ))
{
   $env = (Measure-Command { foreach ($adminflow in (Get-AdminFlow -EnvironmentName $environment.EnvironmentName))
    {
        Write-Host "Environment -" $environment.DisplayName ": Flow -" $adminflow.DisplayName;
        $json = @()
        $individual = (Measure-Command { foreach ($flow in (Get-FlowRun -EnvironmentName $environment.EnvironmentName -FlowName $adminflow.FlowName))
        {
            if ($flow.Status -like 'Failed' -and $flow.StartTime -ge $DateToCheck )
            {
                $json += 
                    @{
                        Environment=$environment.DisplayName;
                        FlowName=$adminflow.DisplayName;
                        FlowRunName=$flow.FlowRunName;
                        Status=$flow.Status;
                        StartTime=$flow.StartTime
                    }
            }
        }}).TotalSeconds
        
        if  ($json.Length -gt 0)
        {
            $Body = ConvertTo-Json -InputObject $json 
            Post-LogAnalyticsData -customerId $CustomerID -sharedKey $SharedKey -logType $LogType -body $Body  

        }
        else {
            Write-Host "Skipped"
        }
        Write-Host ('Completed In :  {0:f2} seconds' -f $individual)   
    }
}).TotalMinutes
Write-Host ('{0} Completed In :  {1:f2} minutes' -f $environment.DisplayName, $env) 
}
}).TotalMinutes

Write-Host ('All Completed In :  {0:f2} minutes' -f $all)   