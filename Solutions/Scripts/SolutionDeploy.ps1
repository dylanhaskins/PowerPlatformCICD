Param(
    [string] [Parameter(Mandatory = $true)] $DeployServerUrl,
    [string] [Parameter(Mandatory = $true)] $UserName,
    [string] [Parameter(Mandatory = $true)] $Password,
    [string] [Parameter(Mandatory = $true)] $PipelinePath
)

######################## SETUP 
. "$PipelinePath\drop\Solutions\Scripts\_SetupTools.ps1"

InstallCoreTools

function Import-Package {
    [string]$PackageDirectory = "$PipelinePath/drop/PackageDeployer/bin/Release"
    [string]$LogsDirectory = "$PackageDirectory"
    [string]$CrmConnectionString = "AuthType=Office365;Username=$UserName; Password=$Password;Url=$DeployServerUrl"

    Write-Host $PackageDirectory
    Write-Host $LogsDirectory
    Write-Host $CrmConnectionString 

    $Packages = Get-Content "$PipelinePath\drop\deployPackages.json" | ConvertFrom-Json

    Write-Host "##[section] Preparing reference Data ..."

    foreach ($package in $Packages) {
        $Deploy = $package.DeployTo | Where-Object { $_.EnvironmentName -eq $env:ENVIRONMENT_NAME }
        if ($null -ne $Deploy) {

            $PFolder = $package.DestinationFolder
            $PSolution = $package.SolutionName
            $Path = "$PackageDirectory/$PFolder"
            $ImportConfig = Get-ChildItem -Path $Path -Include "ImportConfig.xml" -Recurse
            $envName = $env:ENVIRONMENT_NAME.Replace(" ", "")

            [xml] $xdoc = (Get-Content -Path "$($ImportConfig.DirectoryName)\ImportConfig.xml")

            If ($Deploy.DeployData -eq $true) {
                Write-Host "##[section] Enabling Data Import for $PSolution"
                $xdoc.SelectSingleNode("//configdatastorage").crmmigdataimportfile = "$($PSolution).data.zip" 
                Write-Host "##[section] Archiving ReferenceData data file"
                $compressPath = "$PipelinePath\drop\$PFolder\ReferenceData\*"
                Write-Host "Source Path $compressPath"
                $destinationPath = "$PipelinePath\drop\PackageDeployer\bin\Release\$PFolder\$($PSolution).data.zip"
                Write-Host "Destination Path - $destinationPath"
                Compress-Archive -Path $compressPath -CompressionLevel Fastest -DestinationPath $destinationPath -Force              
            }
            else {
                Write-Host "##[section] Disabling Data Import for $PSolution"
                $xdoc.SelectSingleNode("//configdatastorage").crmmigdataimportfile = ""              
            }

            $xdoc.Save("$($ImportConfig.DirectoryName)\ImportConfig.xml")
        }
    }

    InstallXrmDeployModule
    InstallXrmDataModule
            
    Write-Host "##[section] Creating CRM connection"
    $CRMConn = Get-CrmConnection -ConnectionString $CrmConnectionString -Verbose #-MaxCrmConnectionTimeOutMinutes 10      

    if ($false -eq $CRMConn.IsReady) {
        Write-Error "An error occurred: " $CRMConn.LastCrmError
        Write-Error $CRMConn.LastCrmException.Message
        Write-Error $CRMConn.LastCrmException.Source
        Write-Error $CRMConn.LastCrmException.StackTrace
        throw "Could not establish connection with server"
    }

    

    foreach ($package in $Packages) {
        $Deploy = $package.DeployTo | Where-Object { $_.EnvironmentName -eq $env:ENVIRONMENT_NAME }
        if ($null -ne $Deploy) {
            
            $PFolder = $package.DestinationFolder
            $PSolution = $package.SolutionName
            $Path = "$PackageDirectory/$PFolder"

            Write-Host $Path

            $ImportConfig = Get-ChildItem -Path $Path -Include "ImportConfig.xml" -Recurse
            $envName = $env:ENVIRONMENT_NAME.Replace(" ", "")
            
            Write-Host "##[section] Preparing Deployment for - $PSolution"

            [xml] $xdoc = (Get-Content -Path "$($ImportConfig.DirectoryName)\ImportConfig.xml")

            Write-Host "Environment Variables"
            Write-Host "Looking for Path $($ImportConfig.DirectoryName)\EnvironmentVariables\environment_variable_values_$envName.json"
            if (Test-Path -Path "$PipelinePath\drop\$PFolder\Deployment\$PSolution\EnvironmentVariables\environment_variable_values_$envName.json") {
                Write-Host "##[section] Switching Environment Variable for Target Environment"
                $replacementFile = "$PSolution\EnvironmentVariables\environment_variable_values_$envName.json"
                $searchFile = "$PSolution\\EnvironmentVariables\\environment_variable_values.json"
                Write-Host "Searching For - $searchFile"
                Write-Host Replacement File - $replacementFile
                (Get-Content -Path $PipelinePath\drop\$PFolder\map.xml) -replace $searchFile, $replacementFile | Set-Content -Path $PipelinePath\drop\$PFolder\map.xml
                (Get-Content -Path $PipelinePath\drop\$PFolder\map.xml) | Out-Host
            }

            If ($Deploy.DeploymentType -eq "Unmanaged") {
                Write-Host "##[section] Switching $PSolution Solution to Unmanaged"
                $xdoc.SelectNodes("//configsolutionfile[contains(@solutionpackagefilename,'$PSolution')]") | ForEach-Object {                     
                    $folder = ($_.solutionpackagefilename).Replace("_managed.zip", "").Replace(".zip", "")
                    $newFileName = ($_.solutionpackagefilename).Replace("_managed", "")
                    $fileToPack = "$($envName)_$($newFileName)"
                    $_.solutionpackagefilename = $fileToPack
                    $packageFolder = "cdsunpack$($folder)"
                    Write-Host Packing Unmanaged Solution $_.solutionpackagefilename                  
                    &.\Tools\SolutionPackager.exe /action:pack /folder:$PipelinePath\drop\$PFolder\$packageFolder /zipfile:$PipelinePath\drop\PackageDeployer\bin\Release\$PFolder\$fileToPack /packagetype:Unmanaged /map:$PipelinePath\drop\$PFolder\map.xml 
                }
            }
            else {
                Write-Host "##[section] Switching $PSolution Solution to Managed"
                $xdoc.SelectNodes("//configsolutionfile[contains(@solutionpackagefilename,'$PSolution')]") | ForEach-Object {
                    $folder = ($_.solutionpackagefilename).Replace("_managed.zip", "").Replace(".zip", "")
                    $fileToPack = "$($envName)_$($_.solutionpackagefilename)"
                    $_.solutionpackagefilename = $fileToPack                    
                    $packageFolder = "cdsunpack$($folder)"
                    Write-Host Packing Managed Solution  $_.solutionpackagefilename
                    &.\Tools\SolutionPackager.exe /action:pack /folder:$PipelinePath\drop\$PFolder\$packageFolder /zipfile:$PipelinePath\drop\PackageDeployer\bin\Release\$PFolder\$fileToPack /packagetype:Managed /map:$PipelinePath\drop\$PFolder\map.xml 
                }
            }  
            
            $xdoc.Save("$($ImportConfig.DirectoryName)\ImportConfig.xml")
            (Get-Content -Path "$($ImportConfig.DirectoryName)\ImportConfig.xml") | Out-Host
    
            if ($Deploy.PreAction -eq $true) {
                Write-Host "##[section] Execute Pre Action"
                Write-Host "$PipelinePath\drop\$PFolder\bin\release\Scripts"
                . $PipelinePath\drop\$PFolder\bin\release\Scripts\PreAction.ps1 -Conn $CRMConn -EnvironmentName $Deploy.EnvironmentName -Path "$PipelinePath\drop\$PFolder\bin\release\"
            }

            Write-Host "##[section] Importing package"
            $Stoploop = $false
            [int]$Retrycount = "0"
            [int]$RetryMax = "5"
            do {
                try {
                    $error.Clear()

                    Write-Host "##[section] Deploying $($package.SolutionName) as $($Deploy.DeploymentType) to - $env:ENVIRONMENT_NAME" 

                    $PackageInfo = Get-CrmPackages -PackageDirectory $PackageDirectory | Where-Object {$_.PackageShortName -eq $package.SolutionName}
                    Write-Host "Package Info Retrieved - $PackageInfo.PackageShortName"
                    Write-Host Attempt $($Retrycount) of $RetryMax
                    If ($Retrycount -eq 0) {

                            Import-CrmPackage -CrmConnection $CRMConn -PackageInformation $PackageInfo -EnabledAsyncForSolutionImport -SolutionBlockedRetryDelay 120 -SolutionBlockedRetryCount 10 -Timeout "00:15:00" -RuntimePackageSettings $RuntimeSettings -Verbose    
                    }
                    else {
                            Import-CrmPackage -CrmConnection $CRMConn -PackageInformation $PackageInfo -EnabledAsyncForSolutionImport -SolutionBlockedRetryDelay 120 -SolutionBlockedRetryCount 10 -Timeout "00:15:00" -RuntimePackageSettings $RuntimeSettings -Verbose    
                    }

                    $Stoploop = $true
                    Write-Host "##[section] Import Complete."
                }
                catch {
                    if ($Retrycount -ge $RetryMax) { 
                        [System.Management.Automation.ErrorRecord]$error2Report = $error[$error.Count - 1]
                        Write-Host "##vso[task.logissue type=error;] Could not Import after $RetryMax retrys. - $($error2Report.Exception)"
                        Write-Error "##[error] Could not Import after $RetryMax retrys."
                        $Stoploop = $true
                    }
                    if ($error.count -gt 0) {
                        Write-Host "##[warning]Error : $error,  retrying in 30 seconds..."
                        $error.Clear()                    
                        $Retrycount = $Retrycount + 1
                        Start-Sleep -Seconds 30
                    }
                }
            }
            While ($Stoploop -eq $false)

            if ($Deploy.PostAction -eq $true) {
                Write-Host "##[section] Execute Post Action"
                Write-Host "$PipelinePath\drop\$PFolder\bin\release\Scripts"
                . $PipelinePath\drop\$PFolder\bin\release\Scripts\PostAction.ps1 -Conn $CRMConn -EnvironmentName $Deploy.EnvironmentName -Path "$PipelinePath\drop\$PFolder\bin\release\"
            }

        }
        else {
            Write-Host "##[warning] $($package.SolutionName) is not configured for deployment to $env:ENVIRONMENT_NAME in deployPackages.json" 
            Write-Host "##vso[task.logissue type=warning;] $($package.SolutionName) is not configured for deployment to $env:ENVIRONMENT_NAME in deployPackages.json"
        }
    }
}

Write-Host Environment $env:ENVIRONMENT_NAME
Import-Package


