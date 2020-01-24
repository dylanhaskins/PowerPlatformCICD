Param(
    [string] [Parameter(Mandatory = $true)] $DeployServerUrl,
    [string] [Parameter(Mandatory = $true)] $UserName,
    [string] [Parameter(Mandatory = $true)] $Password,
    [string] [Parameter(Mandatory = $true)] $PipelinePath
)

######################## SETUP 
. "$PipelinePath\drop\Solutions\bin\Release\Scripts\_SetupTools.ps1"
. "$PipelinePath\drop\Solutions\bin\Release\Scripts\_Config.ps1"

function Import-Package {
    [string]$PackageName = "PackageDeployer.dll"
    [string]$PackageDirectory = "$PipelinePath/drop/PackageDeployer/bin/Release"
    [string]$LogsDirectory = "$PackageDirectory"
    [string]$CrmConnectionString = "AuthType=Office365;Username=$UserName; Password=$Password;Url=$DeployServerUrl"
    
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

InstallXrmDeployModule
InstallXrmDataModule
Import-Package
