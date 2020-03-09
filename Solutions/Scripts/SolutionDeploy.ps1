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
    [string]$PackageDirectory = "$PipelinePath/drop/PackageDeployer/bin/Release"
    [string]$LogsDirectory = "$PackageDirectory"
    [string]$CrmConnectionString = "AuthType=Office365;Username=$UserName; Password=$Password;Url=$DeployServerUrl"
    
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
       [int]$RetryMax = "5"
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

                     $Packages = Get-Content "$PipelinePath\drop\deployPackages.json" | ConvertFrom-Json

                     foreach ($package in $Packages)
                     {
                         $Deploy = $package.DeployTo | Where-Object {$_.EnvironmentName -eq $env:ENVIRONMENT_NAME}
                         if ($Deploy -ne $null)
                         {
                           If ($Deploy.DeploymentType -eq "Unmanaged")
                             {
                                 $PFolder = $package.DestinationFolder
                                 $Path = "./PackageDeployer/bin/Debug/$PFolder"
                                 $ImportConfig = Get-ChildItem -Path $Path -Include "ImportConfig.xml" -Recurse
                                
                                 (Get-Content -Path "$($ImportConfig.DirectoryName)\ImportConfig.xml") -replace "_managed","" | Set-Content -Path "$($ImportConfig.DirectoryName)\ImportConfig.xml"
                             }
                           Write-Host "##[section] Deploying $($package.SolutionName) as $($Deploy.DeploymentType) to - $env:ENVIRONMENT_NAME" 
                           Import-CrmPackage -CrmConnection $CRMConn -PackageDirectory $PackageDirectory -PackageName $package.PackageName -LogWriteDirectory $LogsDirectory -EnabledAsyncForSolutionImport -SolutionBlockedRetryDelay 120 -SolutionBlockedRetryCount 10 -Timeout "00:08:00" -RuntimePackageSettings $RuntimeSettings -Verbose
                         }
                         else
                         {
                             Write-Host "##[warning] $($package.SolutionName) is not configured for deployment to $env:ENVIRONMENT_NAME in deployPackages.json" 
                             Write-Host "##vso[task.logissue type=warning;] $($package.SolutionName) is not configured for deployment to $env:ENVIRONMENT_NAME in deployPackages.json"
                         }

                     }
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
                     Write-Host "Error : $error,  retrying in 30 seconds..."
                     $error.Clear()                    
                     $Retrycount = $Retrycount + 1
                     Start-Sleep -Seconds 30
              }
              }
       }
       While ($Stoploop -eq $false)
    Write-Host "Import Complete."
}

InstallXrmDeployModule
InstallXrmDataModule
Import-Package
