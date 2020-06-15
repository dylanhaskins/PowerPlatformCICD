Param(
    [string] [Parameter(Mandatory = $false)] $Branch = "master",
    [bool] [Parameter(Mandatory= $false)] $SkipPreReqs = $false
)
$ProgressPreference = 'SilentlyContinue'
$Text = "Power Platform DevOps"
$UniqueId = "PPDevOps"

function Install-XrmModule{
    $moduleName = "Microsoft.Xrm.Data.Powershell"
    $moduleVersion = "2.8.5"
    $module = Get-Module -ListAvailable -Name $moduleName
    if (!($module.Version -ge $moduleVersion )) {
        Write-host "Module $moduleName version $moduleVersion or higher not found, installing now"
        Install-Module -Name $moduleName -MinimumVersion $moduleVersion -Force -Scope CurrentUser
    }
    else
    {
        Write-host "Module $moduleName Found"
    }
}

Function Install-ToastModule{
    $moduleName = "BurntToast"
    if (!(Get-Module -ListAvailable -Name $moduleName )) {
        Write-host "Module $moduleName Not found, installing now"
        Install-Module -Name $moduleName -Force -Scope CurrentUser
    }
    else
    {
        Write-host "Module $moduleName Found"
    }
}

function Format-Json {
    <#
    .SYNOPSIS
        Prettifies JSON output.
    .DESCRIPTION
        Reformats a JSON string so the output looks better than what ConvertTo-Json outputs.
    .PARAMETER Json
        Required: [string] The JSON text to prettify.
    .PARAMETER Minify
        Optional: Returns the json string compressed.
    .PARAMETER Indentation
        Optional: The number of spaces (1..1024) to use for indentation. Defaults to 4.
    .PARAMETER AsArray
        Optional: If set, the output will be in the form of a string array, otherwise a single string is output.
    .EXAMPLE
        $json | ConvertTo-Json  | Format-Json -Indentation 2
    #>
    [CmdletBinding(DefaultParameterSetName = 'Prettify')]
    Param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [string]$Json,

        [Parameter(ParameterSetName = 'Minify')]
        [switch]$Minify,

        [Parameter(ParameterSetName = 'Prettify')]
        [ValidateRange(1, 1024)]
        [int]$Indentation = 4,

        [Parameter(ParameterSetName = 'Prettify')]
        [switch]$AsArray
    )

    if ($PSCmdlet.ParameterSetName -eq 'Minify') {
        return ($Json | ConvertFrom-Json) | ConvertTo-Json -Depth 100 -Compress
    }

    # If the input JSON text has been created with ConvertTo-Json -Compress
    # then we first need to reconvert it without compression
    if ($Json -notmatch '\r?\n') {
        $Json = ($Json | ConvertFrom-Json) | ConvertTo-Json -Depth 100
    }

    $indent = 0
    $regexUnlessQuoted = '(?=([^"]*"[^"]*")*[^"]*$)'

    $result = $Json -split '\r?\n' |
        ForEach-Object {
            # If the line contains a ] or } character, 
            # we need to decrement the indentation level unless it is inside quotes.
            if ($_ -match "[}\]]$regexUnlessQuoted") {
                $indent = [Math]::Max($indent - $Indentation, 0)
            }

            # Replace all colon-space combinations by ": " unless it is inside quotes.
            $line = (' ' * $indent) + ($_.TrimStart() -replace ":\s+$regexUnlessQuoted", ': ')

            # If the line contains a [ or { character, 
            # we need to increment the indentation level unless it is inside quotes.
            if ($_ -match "[\{\[]$regexUnlessQuoted") {
                $indent += $Indentation
            }

            $line
        }

    if ($AsArray) { return $result }
    return $result -Join [Environment]::NewLine
}


function Add-Feature
{

$message = "Connecting to Power Platform"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.10
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

$quit = Read-Host -Prompt "Press Enter to Connect to your CDS / D365 Tenant or [Q]uit"
if ($quit -eq "Q")
{
    exit
}

if (!$Credentials)
{
	Do {
	$Credentials = Get-Credential
    } Until (($Credentials.GetNetworkCredential().UserName -ne "") -and ($Credentials.GetNetworkCredential().Password -ne "")) 
}
if (!$username)
{
$username =  $Credentials.GetNetworkCredential().UserName
$password =  $Credentials.GetNetworkCredential().Password
}

    Install-XrmModule

    $message = "Connecting to Development Environment"
    Write-Host $message
    $ProgressBar = New-BTProgressBar -Status $message -Value 0.20
    New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

    Write-Host ""
    Write-Host "---- Please Select your Development Environment ------"
    Do {
    $conn = Connect-CrmOnlineDiscovery -Credential $Credentials
    If (!$conn.IsReady)
        {
            Do {
	         $Credentials = Get-Credential
            } Until (($Credentials.GetNetworkCredential().UserName -ne "") -and ($Credentials.GetNetworkCredential().Password -ne "")) 
            if (!$username)
            {
                $username =  $Credentials.GetNetworkCredential().UserName
                $password =  $Credentials.GetNetworkCredential().Password
            }
        }
     } Until ($conn.IsReady) 

    $CreateOrSelect = Read-Host -Prompt "Development Environment : Would you like to [C]reate a New Solution or [S]elect an Existing One (Default [S])"
if ($CreateOrSelect -eq "C"){

    $message = "Creating Solution and Publisher"
    Write-Host $message
    $ProgressBar = New-BTProgressBar -Status $message -Value 0.78
    New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

    $CreateOrSelectPub = Read-Host -Prompt "Development Environment : Would you like to [C]reate a New Publisher or [S]elect an Existing One (Default [S])"
    if ($CreateOrSelectPub -eq "C"){

    $PublisherName = Read-Host -Prompt "Enter a Name for your Solution Publisher"
    $PublisherPrefix = Read-Host -Prompt "Enter a Publisher Prefix"

    $PublisherId = New-CrmRecord -EntityLogicalName publisher -Fields @{"uniquename"=$PublisherName.Replace(' ','');"friendlyname"=$PublisherName;"customizationprefix"=$PublisherPrefix.Replace(' ','').ToLower()}
    $PubLookup = New-CrmEntityReference -EntityLogicalName publisher -Id $PublisherId.Guid
    }
    else
    {
           $publisherFetch = @"
    <fetch>
    <entity name='publisher' >
        <filter type='and' >
        <condition attribute='isreadonly' operator='eq' value='false' />
        </filter>
    </entity>
    </fetch>
"@

    $publishers = (Get-CrmRecordsByFetch -conn $conn -Fetch $publisherFetch).CrmRecords

    $choiceIndex = 0
    $options = $publishers | ForEach-Object { write-host "[$($choiceIndex)] $($_.friendlyname)"; $choiceIndex++; }  


    $success = $false
    do {
        $choice = read-host "Enter your selection"
        if (!$choice) {
            Write-Host "Invalid selection (null)"
        }
        else {
            $choice = $choice -as [int];
            if ($choice -eq $null) {
                Write-Host "Invalid selection (not number)"
            }
            elseif ($choice -le -1) {
                Write-Host "Invalid selection (negative)"
            }
            else {
                $chosenPublisher = $publishers[$choice].uniquename
                if ($null -ne $chosenPublisher) {
                    $PublisherPrefix = $publishers[$choice].customizationprefix
                    $PubLookup = New-CrmEntityReference -EntityLogicalName publisher -Id $publishers[$choice].publisherid
                    $success = $true
                }
                else {
                    Write-Host "Invalid selection (index out of range)"
                }
            } 
        }
    } while (!$success)
    }
    $SolutionName = Read-Host -Prompt "Enter a Name for your Unmanaged Development Solution"    
    $SolutionId = New-CrmRecord -EntityLogicalName solution -Fields @{"uniquename"=$SolutionName.Replace(' ','');"friendlyname"=$SolutionName;"version"="1.0.0.0";"publisherid"=$PubLookup}
    $chosenSolution = $SolutionName.Replace(' ','')
    }
    else{

    $solutionFetch = @"
    <fetch>
    <entity name='solution' >
        <filter type='and' >
        <condition attribute='ismanaged' operator='eq' value='0' />
        <condition attribute='isvisible' operator='eq' value='1' />
        </filter>
    </entity>
    </fetch>
"@

    $solutions = (Get-CrmRecordsByFetch -conn $conn -Fetch $solutionFetch).CrmRecords

    $choiceIndex = 0
    $options = $solutions | ForEach-Object { write-host "[$($choiceIndex)] $($_.uniquename)"; $choiceIndex++; }  


    $success = $false
    do {
        $choice = read-host "Enter your selection"
        if (!$choice) {
            Write-Host "Invalid selection (null)"
        }
        else {
            $choice = $choice -as [int];
            if ($choice -eq $null) {
                Write-Host "Invalid selection (not number)"
            }
            elseif ($choice -le -1) {
                Write-Host "Invalid selection (negative)"
            }
            else {
                $chosenSolution = $solutions[$choice].uniquename
                if ($null -ne $chosenSolution) {
                    $PublisherPrefix = (Get-CrmRecord -conn $conn -EntityLogicalName publisher -Id $solutions[$choice].publisherid_Property.Value.Id -Fields customizationprefix).customizationprefix
                    $success = $true
                }
                else {
                    Write-Host "Invalid selection (index out of range)"
                }
            } 
        }
    } while (!$success)
}

#update values in Solution files 
$TextInfo = (Get-Culture).TextInfo

$message = "Copying Solution Template to New $chosenSolution Project"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.30
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

Copy-Item -Path .\SolutionTemplate -Destination $chosenSolution -Recurse 
Set-Location -Path .\$chosenSolution

Set-Location -Path .\..
$message = "Setting Configurations in Source Code"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.40
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

Write-Host "Updating config.json ..."
(Get-Content -Path .\$chosenSolution\Scripts\config.json) -replace "https://AddServer.crm6.dynamics.com",$conn.ConnectedOrgPublishedEndpoints["WebApplication"] | Set-Content -Path .\$chosenSolution\Scripts\config.json
(Get-Content -Path .\$chosenSolution\Scripts\config.json) -replace "AddName",$chosenSolution | Set-Content -Path .\$chosenSolution\Scripts\config.json
(Get-Content -Path .\$chosenSolution\Scripts\_GenerateTypes.ps1) -replace "ProjName",$chosenSolution | Set-Content -Path .\$chosenSolution\Scripts\_GenerateTypes.ps1
(Get-Content -Path .\$chosenSolution\package.json) -replace "featuretemplate",$chosenSolution | Set-Content -Path .\$chosenSolution\package.json

Write-Host "Updating spkl.json ..."
(Get-Content -Path .\$chosenSolution\spkl.json) -replace "AddName",$chosenSolution | Set-Content -Path .\$chosenSolution\spkl.json
(Get-Content -Path .\$chosenSolution\spkl.json) -replace "prefix",$PublisherPrefix.Replace(' ','').ToLower() | Set-Content -Path .\$chosenSolution\spkl.json

Write-Host "Updating ImportConfig.xml ..."
Move-Item .\$chosenSolution\Deployment\FeatureTemplate .\$chosenSolution\Deployment\$chosenSolution
Move-Item .\$chosenSolution\Deployment\FeatureTemplatePackage.cs .\$chosenSolution\Deployment\$($chosenSolution)Package.cs  
(Get-Content -Path .\$chosenSolution\Deployment\$chosenSolution\ImportConfig.xml) -replace "AddName",$chosenSolution | Set-Content -Path .\$chosenSolution\Deployment\$chosenSolution\ImportConfig.xml
(Get-Content -Path .\$chosenSolution\Deployment\$($chosenSolution)Package.cs) -replace "AddName",$chosenSolution | Set-Content -Path .\$chosenSolution\Deployment\$($chosenSolution)Package.cs
(Get-Content -Path .\$chosenSolution\Compile.bat) -replace "FeatureTemplate",$chosenSolution | Set-Content -Path .\$chosenSolution\Compile.bat
(Get-Content -Path .\$chosenSolution\webpack.config.js) -replace "AddName",$chosenSolution.ToLower() | Set-Content -Path .\$chosenSolution\webpack.config.js -ErrorAction Ignore

Write-Host "Updating XrmContext.exe.config ..."
(Get-Content -Path .\$chosenSolution\XrmContext\XrmContext.exe.config) -replace "AddName",$chosenSolution | Set-Content -Path .\$chosenSolution\XrmContext\XrmContext.exe.config

Write-Host "Updating XrmDefinitelyTyped.exe.config ..."
(Get-Content -Path .\$chosenSolution\XrmDefinitelyTyped\XrmDefinitelyTyped.exe.config) -replace "AddName",$chosenSolution | Set-Content -Path .\$chosenSolution\XrmDefinitelyTyped\XrmDefinitelyTyped.exe.config

Write-Host "Rename SolutionTemplate.csproj to $chosenSolution.csproj"
Rename-Item -Path .\$chosenSolution\SolutionTemplate.csproj -NewName "$chosenSolution.csproj"

Write-Host "Rename SolutionTemplate.snk to $chosenSolution.snk"
Rename-Item -Path .\$chosenSolution\SolutionTemplate.snk -NewName "$chosenSolution.snk"

Write-Host "Updating $chosenSolution.csproj ..."
(Get-Content -Path .\$chosenSolution\$chosenSolution.csproj) -replace "FeatureTemplate",$chosenSolution | Set-Content -Path .\$chosenSolution\$chosenSolution.csproj
(Get-Content -Path .\$chosenSolution\$chosenSolution.csproj) -replace "SolutionTemplate",$chosenSolution | Set-Content -Path .\$chosenSolution\$chosenSolution.csproj

(Get-Content -Path .\$chosenSolution\map.xml) -replace "PowerPlatformDevOpsPlugins",($chosenSolution) | Set-Content -Path .\$chosenSolution\map.xml


Write-Host "Adding Solution to packageDeploy.json"
$packagesToDeploy = Get-Content .\deployPackages.json | ConvertFrom-Json
$deployTo = @([ordered]@{EnvironmentName="Deployment Staging";DeploymentType="Managed";DeployData="true"})
if ($packagesToDeploy.Count -gt 0) {
    $packagesToDeploy += [ordered]@{DestinationFolder=$chosenSolution;PackageFolder=$chosenSolution;PackageName="$($chosenSolution)Package.dll";SolutionName=$chosenSolution;DeployTo=$deployTo}     
    ConvertTo-Json -Depth 3 $packagesToDeploy | Format-Json | Out-File .\deployPackages.json
}
else{
    ConvertTo-Json -Depth 3 @(@{DestinationFolder=$chosenSolution;PackageFolder=$chosenSolution;PackageName="$($chosenSolution)Package.dll";SolutionName=$chosenSolution;DeployTo=$deployTo}) | Format-Json | Out-File .\deployPackages.json
}



Set-Location -Path  .\$chosenSolution
# Write-Host "Installing Node module dependencies ..."
# npm install

Set-Location -Path .\Scripts

Write-Host "Exporting Solution and Generating Types"
Start-Process powershell -ArgumentList ".\SolutionExport.ps1" -Wait

Set-Location -Path .\..

Write-Host "Adding $chosenSolution Project to Solution"
Set-Location .\..
$sln = Get-ChildItem *.sln
dotnet sln $sln.Name add $chosenSolution\$chosenSolution.csproj
dotnet sln $sln.Name remove SolutionTemplate\SolutionTemplate.csproj

#commit repo and update VariableGroup in DevOps

git add -A
git commit -m "Added Solution $chosenSolution"

$message = "Complete ... Enjoy !!!"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 1
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId
}

$message = @"
____                          ____  _       _    __                        ____              ___            
|  _ \ _____      _____ _ __  |  _ \| | __ _| |_ / _| ___  _ __ _ __ ___   |  _ \  _____   __/ _ \ _ __  ___ 
| |_) / _ \ \ /\ / / _ \ '__| | |_) | |/ _` | __| |_ / _ \| '__| '_ ` _ \  | | | |/ _ \ \ / / | | | '_ \/ __|
|  __/ (_) \ V  V /  __/ |    |  __/| | (_| | |_|  _| (_) | |  | | | | | | | |_| |  __/\ V /| |_| | |_) \__ \
|_|   \___/ \_/\_/ \___|_|    |_|   |_|\__,_|\__|_|  \___/|_|  |_| |_| |_| |____/ \___| \_/  \___/| .__/|___/
                                                                                                  |_|        



Welcome to the Power Platform DevOps Solution Add script. This script will perform the following steps automatically :

- Install Pre-requisites (Dotnet Core CLI)
- Connect to CDS to Get Solution
- Add Development Solution Project to your Visual Studio Solution

 
"@

Write-Host $message

$quit = Read-Host -Prompt "Press Enter to Continue or [Q]uit"
if ($quit -eq "Q")
{
    exit
}
    
Write-Host("Performing Checks....")
Install-ToastModule
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
if (!$env:ChocolateyInstall) {
    Write-Warning "The ChocolateyInstall environment variable was not found. `n Chocolatey is not detected as installed. Installing..."
    $message = "Installing Chocolatey ...."
    Write-Host $message
    $ProgressBar = New-BTProgressBar -Status $message -Value 0.12
    New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

if (!$SkipPreReqs) {
    choco upgrade chocolatey -y
    choco upgrade dotnetcore --version=3.1.2 -y   
}


Add-Feature
$ProgressPreference = 'Continue'
