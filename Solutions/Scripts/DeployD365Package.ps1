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

	Write-Verbose "Importing: Microsoft.Xrm.Data.PowerShell" 
    Import-Module -Name Microsoft.Xrm.Data.PowerShell -RequiredVersion 2.8.1.3 -Force -Scope Global
    Write-Verbose "Imported: Microsoft.Xrm.Data.PowerShell"
}

function Import-Package {

	Write-Host "Preparing Data Package"
	& "$env:SYSTEM_DEFAULTWORKINGDIRECTORY/$env:RELEASE_PRIMARYARTIFACTSOURCEALIAS/drop/Solutions/bin/Release/Scripts/DataPackagePack.ps1"

    [string]$PackageName = "PackageDeployer"
    [string]$PackageDirectory = "$env:SYSTEM_DEFAULTWORKINGDIRECTORY/$env:RELEASE_PRIMARYARTIFACTSOURCEALIAS/drop/PackageDeployer/bin/Release"
    [string]$LogsDirectory = "$PackageDirectory"
    [string]$CrmConnectionString = "AuthType=Office365;Username=$UserName; Password=$Password;Url=$ServerUrl"
    
    Write-Host $PackageName
    Write-Host $PackageDirectory
    Write-Host $LogsDirectory
    Write-Host $CrmConnectionString 
    
    Write-Host "Creating CRM connection"
    
	[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
    $CRMConn = Get-CrmConnection -ConnectionString $CrmConnectionString -Verbose #-MaxCrmConnectionTimeOutMinutes 15
    
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
	[int]$RetryMax = "30"
	$EnableThrow = $false
	do
	{
		try
		{
			if ($Retrycount -eq 0) {
				Import-CrmPackage -CrmConnection $CRMConn -PackageDirectory $PackageDirectory -PackageName $PackageName -LogWriteDirectory $LogsDirectory -EnabledAsyncForSolutionImport -SolutionBlockedRetryDelay 120 -SolutionBlockedRetryCount 10 -Timeout "00:20:00" -Verbose -ErrorAction SilentlyContinue
				Write-Host "Initial Package Import Complete"
				$Error.Clear()
				$Stoploop = $true
            }
			if ($Retrycount -ge $RetryMax) {
				Write-Host "Max Retries reached - RetryCount = $Retrycount"
				$EnableThrow = $true
				throw $Error
				$Stoploop = $true
			}

			Write-Host "Checking for In Progress Solution Import - RetryCount = $Retrycount"
			$theRecords = Get-CrmRecords -conn $CRMConn -EntityLogicalName solution -Fields version,friendlyname,uniquename,description -FilterAttribute uniquename -FilterOperator begins-with -FilterValue CCMSCore_Upgrade
			if ($theRecords.CrmRecords.Count -gt 0)
			{
				Write-Host "Retrying Package Import"
				Import-CrmPackage -CrmConnection $CRMConn -PackageDirectory $PackageDirectory -PackageName $PackageName -LogWriteDirectory $LogsDirectory -EnabledAsyncForSolutionImport -SolutionBlockedRetryDelay 120 -SolutionBlockedRetryCount 10 -Timeout "00:20:00" -Verbose -ErrorAction SilentlyContinue
				$Error.Clear()
				$Stoploop = $true
			}
			else
			{
				Write-Host "Else Stop Loop"
				$Stoploop = $true
				if	($Error) {
				$EnableThrow = $true
				Write-Host "Throwing Error"
				Throw $Error}
				
			}
		}
		catch
		{
			Write-Host ("Caught Exception via Try - $Error")
            #$Error.Clear()
			if ($EnableThrow) {Write-Error $_}
			Else
			{
			$Retrycount = $Retrycount + 1
			}
		}
	}
	While ($Stoploop -eq $false)

    Write-Host "Import Complete."
}

Install-XrmModule
Import-Package