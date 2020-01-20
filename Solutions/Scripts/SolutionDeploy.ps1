Param(
    [string] [Parameter(Mandatory = $true)] $ServerUrl,
    [string] [Parameter(Mandatory = $true)] $UserName,
    [string] [Parameter(Mandatory = $true)] $Password
)


function Install-XrmModule {
    Write-Host "Installing Package"

    $currentFolder = Get-Location
    cd $currentFolder
    $sourceNugetExe = "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe"
    $targetNugetExe = ".\nuget.exe"
    Remove-Item .\Tools -Force -Recurse -ErrorAction Ignore
    Invoke-WebRequest $sourceNugetExe -OutFile $targetNugetExe
    Set-Alias nuget $targetNugetExe -Scope Global -Verbose

    ##
    ##Specify the NuGet package source
    ##
    $nugetPackageSource = "https://api.nuget.org/v3/index.json"

    ##
    ##Download XRM Tooling PowerShell cmdlets
    ##
    ./nuget install -source $nugetPackageSource Microsoft.CrmSdk.XrmTooling.PackageDeployment.PowerShell -O .\Tools
    md .\Tools\XRMToolingPowerShell
    $cmdletFolder = Get-ChildItem ./Tools | Where-Object { $_.Name -match 'Microsoft.CrmSdk.XrmTooling.PackageDeployment.PowerShell.' }
    Write-Host $cmdletFolder
    move .\Tools\$cmdletFolder\tools\*.* .\Tools\XRMToolingPowerShell
    Remove-Item .\Tools\$cmdletFolder -Force -Recurse


    ##
    ##Remove NuGet.exe
    ##
    Remove-Item nuget.exe

    $crmToolingConnector = (Get-Location).Path + "\Tools\XRMToolingPowerShell\Microsoft.Xrm.Tooling.PackageDeployment.Powershell\Microsoft.Xrm.Tooling.CrmConnector.Powershell.dll"
    $crmToolingDeployment = (Get-Location).Path + "\Tools\XRMToolingPowerShell\Microsoft.Xrm.Tooling.PackageDeployment.Powershell\Microsoft.Xrm.Tooling.PackageDeployment.Powershell.dll"
    

    Write-Verbose "Importing: $crmToolingConnector" 
    Import-Module $crmToolingConnector
    Write-Verbose "Imported: $crmToolingConnector"

    Write-Verbose "Importing: $crmToolingDeployment" 
    Import-Module $crmToolingDeployment
    Write-Verbose "Imported: $crmToolingDeployment"
}

function Import-Package {
    [string]$PackageName = "CCMSPortalDeploymentPackage.dll"
    [string]$PackageDirectory = "$env:SYSTEM_DEFAULTWORKINGDIRECTORY/$env:RELEASE_PRIMARYARTIFACTSOURCEALIAS/drop/PackageDeployer/bin/Release"
    [string]$LogsDirectory = "$PackageDirectory"
    [string]$CrmConnectionString = "AuthType=Office365;Username=$UserName; Password=$Password;Url=$ServerUrl"
    
    Write-Host $PackageName
    Write-Host $PackageDirectory
    Write-Host $LogsDirectory
    Write-Host $CrmConnectionString 
    
    Write-Host "Creating CRM connection"
    
    $CRMConn = Get-CrmConnection -ConnectionString $CrmConnectionString -Verbose #-MaxCrmConnectionTimeOutMinutes 30
    
    if ($false -eq $CRMConn.IsReady) {
        Write-Error "An error occurred: " $CRMConn.LastCrmError
        Write-Error $CRMConn.LastCrmException.Message
        Write-Error $CRMConn.LastCrmException.Source
        Write-Error $CRMConn.LastCrmException.StackTrace
        throw "Could not establish connection with server"
    }

  Write-Host "Importing package"
    $Stoploop = $false
       [int]$Retrycount = "0"
       [int]$RetryMax = "20"
       do
       {
              try
              {
                        Write-Host "Creating CRM connection"
                        $CRMConn = Get-CrmConnection -ConnectionString $CrmConnectionString -Verbose #-MaxCrmConnectionTimeOutMinutes 10      
    
                       if ($false -eq $CRMConn.IsReady) {
                            Write-Error "An error occurred: " $CRMConn.LastCrmError
                             Write-Error $CRMConn.LastCrmException.Message
                              Write-Error $CRMConn.LastCrmException.Source
                               Write-Error $CRMConn.LastCrmException.StackTrace
                            throw "Could not establish connection with server"
                        }
                     $error.Clear()
                     Import-CrmPackage -CrmConnection $CRMConn -PackageDirectory $PackageDirectory -PackageName $PackageName -LogWriteDirectory $LogsDirectory -EnabledAsyncForSolutionImport -SolutionBlockedRetryDelay 120 -SolutionBlockedRetryCount 10 -Timeout "00:60:00" -RuntimePackageSettings $RuntimeSettings -Verbose
                     $Stoploop = $true
              }
              catch
              {
                     if ($Retrycount -gt $RetryMax){
                     Write-Host "Could not Import after $RetryMax retrys."
                     $Stoploop = $true
              }
              if ($error.count -gt 0)
              {
                     Write-Host "Error : $error,  retrying in 120 seconds..."
                     $error.Clear()                    
                     $Retrycount = $Retrycount + 1
                     Start-Sleep -Seconds 120
              }
              }
       }
       While ($Stoploop -eq $false)
    Write-Host "Import Complete."
}

Install-XrmModule
Import-Package
