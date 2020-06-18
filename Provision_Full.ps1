Param(
    [boolean] [Parameter(Mandatory = $false)] $PerformInstall = $false,
    [string] [Parameter(Mandatory = $false)] $Branch = "master"
)

$Text = "Power Platform DevOps"
$UniqueId = "PPDevOps"
$Version = "2.0.180620.2022"

function Restart-PowerShell
{
    Start-Sleep -Seconds 5
    refreshenv
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
    Clear-Host
    Install-DevOps
}

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

function Install-PowerAppsAdmin{
$moduleName = "Microsoft.PowerApps.Administration.PowerShell"
$moduleVersion = "2.0.33"
$module = Get-Module -ListAvailable -Name $moduleName
if (!($module.Version -ge $moduleVersion )) {
     Write-host "Module $moduleName version $moduleVersion or higher not found, installing now"
     Install-Module -Name $moduleName -RequiredVersion $moduleVersion -Force -AllowClobber
   }
   else
   {
     Write-host "Module $moduleName version $moduleVersion or higher Found"
   }
}

function Install-PowerAppsPowerShell{
$moduleName = "Microsoft.PowerApps.PowerShell"
if (!(Get-Module -ListAvailable -Name $moduleName )) {
Write-host "Module $moduleName Not found, installing now"
Install-Module -Name $moduleName -Force -Scope CurrentUser -AllowClobber
}
else
{
Write-host "Module $moduleName Found"
}
}

function Install-PreReq
{
    if (!$env:ChocolateyInstall) {
        Write-Warning "The ChocolateyInstall environment variable was not found. `n Chocolatey is not detected as installed. Installing..."
        $message = "Installing Chocolatey ...."
        Write-Host $message
        $ProgressBar = New-BTProgressBar -Status $message -Value 0.12
        New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId
    
        Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }

    choco upgrade chocolatey -y
 
    $message = "Installing Git ...."
    Write-Host $message
    $ProgressBar = New-BTProgressBar -Status $message -Value 0.15
    New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

    choco upgrade git.install -y

    $message = "Installing NodeJS ...."
    Write-Host $message
    $ProgressBar = New-BTProgressBar -Status $message -Value 0.17
    New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

    choco upgrade nodejs-lts -y

    $message = "Installing Azure CLI ...."
    Write-Host $message
    $ProgressBar = New-BTProgressBar -Status $message -Value 0.18
    New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId
    choco upgrade azure-cli -y 

    $message = "Installing dotnet CLI ...."
    Write-Host $message
    $ProgressBar = New-BTProgressBar -Status $message -Value 0.19
    New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

    choco upgrade dotnetcore -y

    ## Restart PowerShell Environment to Enable Azure CLI
    Restart-PowerShell
}

function Confirm-DevOps-PreReq
{
    $message = "Checking Pre-requisites"
    Write-Host $message
    $ProgressBar = New-BTProgressBar -Status $message -Value 0.1
    New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

    Install-PreReq
}

function Install-DevOps
{
## Install Azure DevOps Extension
$message = "Installing azure-devops extenstion"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.20
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

az extension add --name azure-devops

$ErrorActionPreference = "SilentlyContinue"
Remove-Item AzureCli.msi

$message = "Connecting to Azure DevOps Organisation"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.30
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

$adoOrg = Read-Host -Prompt "Enter the name of your Azure DevOps Organisation (https://dev.azure.com/<Name>)"

$quit = Read-Host -Prompt "You will now be redirected to a Browser to Login to your Azure DevOps Organisation - Press Enter to Continue or [Q]uit"
if ($quit -eq "Q")
{
    exit
}

$azSubs = az login --allow-no-subscriptions

Write-Host ""
[console]::ForegroundColor = "White"
$adoCreate = Read-Host -Prompt "Would you like to [C]reate a new Azure DevOps Project or [S]elect and existing one (Default [S])"

if ($adoCreate -eq "C")
{
  $adoProject = Read-Host -Prompt "Please enter the Name of the Project you wish to Create"

$message = "Creating DevOps Project $adoProject"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.35
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

  az devops project create --name $adoProject --organization=https://dev.azure.com/$adoOrg --process Scrum
}
else {
    $selection = az devops project list --organization=https://dev.azure.com/$adoOrg --query '[value][].{Name:name}' --output json | Out-String | ConvertFrom-Json
    $choiceIndex = 0
    $options = $selection | ForEach-Object { New-Object System.Management.Automation.Host.ChoiceDescription "&$($choiceIndex) - $($_.Name)"; $choiceIndex++ }
    $chosenIndex = $host.ui.PromptForChoice("DevOps Project", "Select the Project you wish to use", $options, 0)
    $adoProject = $selection[$chosenIndex].Name 

}

if ($adoCreate -eq "C")
{
  $adoRepo = $adoProject
  $adoRepo = $adoRepo.Replace(' ','')
  az devops configure --defaults organization=https://dev.azure.com/$adoOrg project=$adoProject
  $repo = az repos show --repository $adoRepo | Out-String | ConvertFrom-Json
}
else
{
  Write-Host ""
  $adoRepo = Read-Host -Prompt "Enter the name for the Git Repository you wish to Create"
    $adoRepo = $adoRepo.Replace(' ','')

$message = "Creating Git Repo $adoRepo"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.38
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

az devops configure --defaults organization=https://dev.azure.com/$adoOrg project=$adoProject

$repo = az repos create --name $adoRepo | Out-String | ConvertFrom-Json

}

az repos import create --git-source-url https://github.com/dylanhaskins/PowerPlatformCICD.git --repository $adoRepo

$message = "Cloning Git Repo $adoRepo locally"
Write-Host $message
Write-Host "If prompted for credentials, enter the same credentials you used for dev.azure.com"
$ProgressBar = New-BTProgressBar -Status $message -Value 0.40
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

git clone $repo.webUrl \Dev\Repos\$adoRepo 

# $message = "Create $adoRepo Azure AD Application"
# Write-Host $message
# $ProgressBar = New-BTProgressBar -Status $message -Value 0.50
# New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

# $manifest = Invoke-WebRequest "https://github.com/dylanhaskins/PowerPlatformCICD/raw/$branch/manifest.json" -UseBasicParsing:$true
# Set-Content .\manifest.json -Value $manifest.Content

# $adApp = az ad app create --display-name "$adoRepo App" --native-app --required-resource-accesses manifest.json --reply-urls "urn:ietf:wg:oauth:2.0:oob" | ConvertFrom-Json
# $azureADAppPassword = (New-Guid).Guid.Replace("-","")
# $adAppCreds = az ad app credential reset --password $azureADAppPassword --id $adApp.appId | ConvertFrom-Json

Set-Location -Path \Dev\Repos\$adoRepo\

$message = "Confirming Git User Details"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.59
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

$GitUser = git config --global user.name
$GitEmail = git config --global user.email

If ($null -eq $GitUser){
    $GitUser = Read-Host "Enter your name (to use when committing changes to Git)"
    git config --global user.name $GitUser
}

If ($null -eq $GitEmail){
    $GitEmail = Read-Host "Enter your email address (to use when committing changes to Git)"
    git config --global user.email $GitEmail
}

$message = "Cleaning up Git Repository"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.60
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

git checkout $branch
git branch | select-string -notmatch $branch | ForEach-Object {git branch -D ("$_").Trim()} #Remove non-used local branches
git branch -r | select-string -notmatch master | select-string -notmatch HEAD | ForEach-Object { git push origin --delete ("$_").Replace("origin/","").Trim()} #Remove non-used branches from remote

Remove-Item .git -Recurse -Force
git init
git add .
git remote add origin $repo.webUrl

Set-Location -Path \Dev\Repos\$adoRepo\Solutions\Scripts

Write-Host ""
Write-Host ""

$message = "Connecting to Power Platform"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.70
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

    # Add-PowerAppsAccount -Username $Credentials.UserName -Password $Credentials.Password

    # $Locations = Get-AdminPowerAppEnvironmentLocations

    # $choiceIndex = 0
    # $options = $Locations | ForEach-Object { write-Host "[$($choiceIndex)] $($_.LocationDisplayName)"; $choiceIndex++; }
    # $geoselect = Read-Host "Please select the Geography for your Power Platform "
    # $Geography = $Locations[$geoselect].LocationName

    Install-XrmModule

#     $message = "Connecting to Development Environment"
#     Write-Host $message
#     $ProgressBar = New-BTProgressBar -Status $message -Value 0.75
#     New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

#     Write-Host ""
#     Write-Host "---- Please Select your Development Environment ------"
#     Do {
#     $conn = Connect-CrmOnlineDiscovery -Credential $Credentials
#     If (!$conn.IsReady)
#         {
#             Do {
# 	         $Credentials = Get-Credential
#             } Until (($Credentials.GetNetworkCredential().UserName -ne "") -and ($Credentials.GetNetworkCredential().Password -ne "")) 
#             if (!$username)
#             {
#                 $username =  $Credentials.GetNetworkCredential().UserName
#                 $password =  $Credentials.GetNetworkCredential().Password
#             }
#         }
# 	} Until ($conn.IsReady) 

#     $CreateOrSelect = Read-Host -Prompt "Development Environment : Would you like to [C]reate a New Solution or [S]elect an Existing One (Default [S])"
# if ($CreateOrSelect -eq "C"){

#     $message = "Creating Solution and Publisher"
#     Write-Host $message
#     $ProgressBar = New-BTProgressBar -Status $message -Value 0.78
#     New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

#     $CreateOrSelectPub = Read-Host -Prompt "Development Environment : Would you like to [C]reate a New Publisher or [S]elect an Existing One (Default [S])"
#     if ($CreateOrSelectPub -eq "C"){

#     $PublisherName = Read-Host -Prompt "Enter a Name for your Solution Publisher"
#     $PublisherPrefix = Read-Host -Prompt "Enter a Publisher Prefix"

#     $PublisherId = New-CrmRecord -EntityLogicalName publisher -Fields @{"uniquename"=$PublisherName.Replace(' ','').ToLower();"friendlyname"=$PublisherName;"customizationprefix"=$PublisherPrefix.Replace(' ','').ToLower()}
#     $PubLookup = New-CrmEntityReference -EntityLogicalName publisher -Id $PublisherId.Guid
#     }
#     else
#     {
#            $publisherFetch = @"
#     <fetch>
#     <entity name='publisher' >
#         <filter type='and' >
#         <condition attribute='isreadonly' operator='eq' value='false' />
#         </filter>
#     </entity>
#     </fetch>
# "@

#     $publishers = (Get-CrmRecordsByFetch -conn $conn -Fetch $publisherFetch).CrmRecords

#     $choiceIndex = 0
#     $options = $publishers | ForEach-Object { write-host "[$($choiceIndex)] $($_.friendlyname)"; $choiceIndex++; }  


#     $success = $false
#     do {
#         $choice = read-host "Enter your selection"
#         if (!$choice) {
#             Write-Host "Invalid selection (null)"
#         }
#         else {
#             $choice = $choice -as [int];
#             if ($choice -eq $null) {
#                 Write-Host "Invalid selection (not number)"
#             }
#             elseif ($choice -le -1) {
#                 Write-Host "Invalid selection (negative)"
#             }
#             else {
#                 $chosenPublisher = $publishers[$choice].uniquename
#                 if ($null -ne $chosenPublisher) {
#                     $PublisherPrefix = $publishers[$choice].customizationprefix
#                     $PubLookup = New-CrmEntityReference -EntityLogicalName publisher -Id $publishers[$choice].publisherid
#                     $success = $true
#                 }
#                 else {
#                     Write-Host "Invalid selection (index out of range)"
#                 }
#             } 
#         }
#     } while (!$success)
#     }
#     $SolutionName = Read-Host -Prompt "Enter a Name for your Unmanaged Development Solution"    
#     $SolutionId = New-CrmRecord -EntityLogicalName solution -Fields @{"uniquename"=$SolutionName.Replace(' ','');"friendlyname"=$SolutionName;"version"="1.0.0.0";"publisherid"=$PubLookup}
#     $chosenSolution = $SolutionName.Replace(' ','')
#     }
#     else{

#     $solutionFetch = @"
#     <fetch>
#     <entity name='solution' >
#         <filter type='and' >
#         <condition attribute='ismanaged' operator='eq' value='0' />
#         <condition attribute='isvisible' operator='eq' value='1' />
#         </filter>
#     </entity>
#     </fetch>
# "@

#     $solutions = (Get-CrmRecordsByFetch -conn $conn -Fetch $solutionFetch).CrmRecords

#     $choiceIndex = 0
#     $options = $solutions | ForEach-Object { write-host "[$($choiceIndex)] $($_.uniquename)"; $choiceIndex++; }  


#     $success = $false
#     do {
#         $choice = read-host "Enter your selection"
#         if (!$choice) {
#             Write-Host "Invalid selection (null)"
#         }
#         else {
#             $choice = $choice -as [int];
#             if ($choice -eq $null) {
#                 Write-Host "Invalid selection (not number)"
#             }
#             elseif ($choice -le -1) {
#                 Write-Host "Invalid selection (negative)"
#             }
#             else {
#                 $chosenSolution = $solutions[$choice].uniquename
#                 if ($null -ne $chosenSolution) {
#                     $PublisherPrefix = (Get-CrmRecord -conn $conn -EntityLogicalName publisher -Id $solutions[$choice].publisherid_Property.Value.Id -Fields customizationprefix).customizationprefix
#                     $success = $true
#                 }
#                 else {
#                     Write-Host "Invalid selection (index out of range)"
#                 }
#             } 
#         }
#     } while (!$success)
# }

# #update values in Solution files 
# $message = "Setting Configurations in Source Code"
# Write-Host $message
# $ProgressBar = New-BTProgressBar -Status $message -Value 0.80
# New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

# Write-Host "Updating config.json ..."
# (Get-Content -Path \Dev\Repos\$adoRepo\Solutions\Scripts\config.json) -replace "https://AddName.crm6.dynamics.com",$conn.ConnectedOrgPublishedEndpoints["WebApplication"] | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\Scripts\config.json
# (Get-Content -Path \Dev\Repos\$adoRepo\Solutions\Scripts\config.json) -replace "AddName",$chosenSolution | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\Scripts\config.json
# (Get-Content -Path \Dev\Repos\$adoRepo\Solutions\Scripts\config.json) -replace "AddGeography",$Geography | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\Scripts\config.json

# Write-Host "Updating deployPackages.json ..."
# (Get-Content -Path \Dev\Repos\$adoRepo\deployPackages.json) -replace "AddName",$chosenSolution | Set-Content -Path \Dev\Repos\$adoRepo\deployPackages.json

# Write-Host "Updating spkl.json ..."
# (Get-Content -Path \Dev\Repos\$adoRepo\Solutions\spkl.json) -replace "AddName",$chosenSolution | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\spkl.json
# (Get-Content -Path \Dev\Repos\$adoRepo\Solutions\spkl.json) -replace "prefix",$PublisherPrefix.Replace(' ','').ToLower() | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\spkl.json

# Write-Host "Updating ImportConfig.xml ..."
# (Get-Content -Path \Dev\Repos\$adoRepo\PackageDeployer\PkgFolder\ImportConfig.xml) -replace "AddName",$chosenSolution | Set-Content -Path \Dev\Repos\$adoRepo\PackageDeployer\PkgFolder\ImportConfig.xml

Write-Host "Updating Build.yaml ..."
(Get-Content -Path \Dev\Repos\$adoRepo\build.yaml) -replace "replaceRepo",$adoRepo | Set-Content -Path \Dev\Repos\$adoRepo\build.yaml
(Get-Content -Path \Dev\Repos\$adoRepo\build.yaml) -replace "AddName",$chosenSolution | Set-Content -Path \Dev\Repos\$adoRepo\build.yaml

# Write-Host "Updating XrmContext.exe.config ..."
# (Get-Content -Path \Dev\Repos\$adoRepo\Solutions\XrmContext\XrmContext.exe.config) -replace "AddName",$chosenSolution | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\XrmContext\XrmContext.exe.config

# Write-Host "Updating XrmDefinitelyTyped.exe.config ..."
# (Get-Content -Path \Dev\Repos\$adoRepo\Solutions\XrmDefinitelyTyped\XrmDefinitelyTyped.exe.config) -replace "AddName",$chosenSolution | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\XrmDefinitelyTyped\XrmDefinitelyTyped.exe.config

# Write-Host "Updating Companion App Settings"
# (Get-Content -Path \Dev\Repos\$adoRepo\PortalCompanionApp\AppSettings.json) -replace "https://AddName.crm6.dynamics.com",$conn.ConnectedOrgPublishedEndpoints["WebApplication"] | Set-Content -Path \Dev\Repos\$adoRepo\PortalCompanionApp\AppSettings.json

# Write-Host "Updating Webhook Settings"
# (Get-Content -Path \Dev\Repos\$adoRepo\Webhook\local.settings.json) -replace "https://AddName.crm6.dynamics.com",$conn.ConnectedOrgPublishedEndpoints["WebApplication"] | Set-Content -Path \Dev\Repos\$adoRepo\Webhook\local.settings.json

Write-Host "Rename PowerPlatformDevOps.sln to $adoRepo.sln"
Rename-Item -Path \Dev\Repos\$adoRepo\PowerPlatformDevOps.sln -NewName "$adoRepo.sln"
# (Get-Content -Path \Dev\Repos\$adoRepo\Plugins\Plugins.csproj) -replace "PowerPlatformDevOpsPlugins",($adoRepo+"Plugins") | Set-Content -Path \Dev\Repos\$adoRepo\Plugins\Plugins.csproj
# (Get-Content -Path \Dev\Repos\$adoRepo\Solutions\map.xml) -replace "PowerPlatformDevOpsPlugins",($adoRepo+"Plugins") | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\map.xml
# (Get-Content -Path \Dev\Repos\$adoRepo\Workflows\Workflows.csproj) -replace "PowerPlatformDevOpsWorkflows",($adoRepo+"Workflows") | Set-Content -Path \Dev\Repos\$adoRepo\Workflows\Workflows.csproj
# (Get-Content -Path \Dev\Repos\$adoRepo\Solutions\map.xml) -replace "PowerPlatformDevOpsWorkflows",($adoRepo+"Workflows") | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\map.xml


$message = "Connecting to Deployment Staging (CI/CD)"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.85
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

Write-Host ""
Write-Host "---- Please Select your Deployment Staging (CI/CD) Environment ------"
$connCICD = Connect-CrmOnlineDiscovery -Credential $Credentials 

# . ".\SolutionExport.ps1"
    
#commit repo and update VariableGroup in DevOps

git add -A
git commit -m "Initial Commit"

Set-Location -Path \Dev\Repos\$adoRepo\
Write-Host "Add Solution..."
. .\AddSolution_Full.ps1 -SkipPreReqs $true
git push origin master --force

$message = "Creating variable groups in Azure DevOps"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.90
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

$varGroup = az pipelines variable-group create --name "$adoRepo.D365DevEnvironment"  --variables d365username=$username --authorize $true | ConvertFrom-Json
az pipelines variable-group variable create --name d365password --value $password --secret $true --group-id $varGroup.id
az pipelines variable-group variable create --name d365url --value "To Be Configured"  --group-id $varGroup.id

$varGroupCICD = az pipelines variable-group create --name "$adoRepo.D365CDEnvironment"  --variables d365username=$username --authorize $true| ConvertFrom-Json
az pipelines variable-group variable create --name d365password --value $password --secret $true --group-id $varGroupCICD.id
# az pipelines variable-group variable create --name aadTenant --value $adAppCreds.tenant --group-id $varGroupCICD.id
# az pipelines variable-group variable create --name aadPowerAppId --value $adAppCreds.appId --group-id $varGroupCICD.id
# az pipelines variable-group variable create --name aadPowerAppSecret --value $adAppCreds.password --secret $true --group-id $varGroupCICD.id
az pipelines variable-group variable create --name d365url --value $connCICD.ConnectedOrgPublishedEndpoints["WebApplication"]  --group-id $varGroupCICD.id

$varGroupTest = az pipelines variable-group create --name "$adoRepo.D365TestEnvironment"  --variables d365username=$username --authorize $true| ConvertFrom-Json
az pipelines variable-group variable create --name d365password --value $password --secret $true --group-id $varGroupTest.id
az pipelines variable-group variable create --name d365url --value "To Be Configured"  --group-id $varGroupTest.id

$message = "Creating Build and Deploy Pipeline in Azure DevOps"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.95
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

$pipeline = az pipelines create --name "$adoRepo.CI" --yml-path /build.yaml --repository $adoRepo --repository-type tfsgit --branch master | ConvertFrom-Json

az repos show --repository $repo.id --open
az pipelines show --id $pipeline.definition.id --open

[console]::ForegroundColor = "White"
#Provision Azure Resource group 
Write-Host "Setting up the Azure Resource group requires both Azure and your Power Platform/Dynamics 365 to be on the same Azure AD Tenant"
$AzureSetup = Read-Host -Prompt "Azure subscriptions : Would you like to create the default Azure resources [Y] Yes or [S] Skip (Default [S])"

if ($AzureSetup -eq "Y"){
    
    $selection =  az login | Out-String | ConvertFrom-Json
    $choiceIndex = 0
    $selection | ForEach-Object { write-host "[$($choiceIndex)] $($_.Name)"; $choiceIndex++; }     
    $subscriptionName = $null 
    $success = $false

    do {
        $choice = read-host "Select the Azure Subscription you want to deploy to"
        if (!$choice) {
            Write-Host "Invalid selection (null)"
        }
        else {
            $choice = $choice -as [int];
            if ($null -eq $choice) {
                Write-Host "Invalid selection (not number)"
            }
            elseif ($choice -le -1) {
                Write-Host "Invalid selection (negative)"
            }
            else {
                $subscriptionId = $selection[$choice].id
                $subscriptionName = $selection[$choice].name
                if ($null -ne $subscriptionName) {
                   Write-Host "Selected Subscription : $subscriptionName"
                   $success = $true
                }
                else {
                    Write-Host "Invalid selection (index out of range)"
                }
            } 
        }
    } while (!$success)

    az account set --subscription $subscriptionId

    $selection =  az account list-locations --output json | Out-String | ConvertFrom-Json
    $choiceIndex = 0
    $selection | ForEach-Object { write-host "[$($choiceIndex)] $($_.name)"; $choiceIndex++; } 
    $regionName = $null 
    $success = $false

    do {
        $choice = read-host "Select the Azure Region you want to deploy to"
        if (!$choice) {
            Write-Host "Invalid selection (null)"
        }
        else {
            $choice = $choice -as [int];
            if ($null -eq $choice) {
                Write-Host "Invalid selection (not number)"
            }
            elseif ($choice -le -1) {
                Write-Host "Invalid selection (negative)"
            }
            else {
                $regionName = $selection[$choice].name
                if ($null -ne $regionName) {
                   Write-Host "Selected Region : $regionName"
                   $success = $true
                }
                else {
                    Write-Host "Invalid selection (index out of range)"
                }
            } 
        }
    } while (!$success)



    Write-Host "Updating ARM Parameter values"
    $adoRepoLower = $adoRepo.ToLower()
    (Get-Content -Path \Dev\Repos\$adoRepo\AzureResources\azuredeploy.parameters.json) -replace "AddName" , $adoRepoLower | Set-Content -Path \Dev\Repos\$adoRepo\AzureResources\azuredeploy.parameters.json
    (Get-Content -Path \Dev\Repos\$adoRepo\AzureResources\azuredeploy.parameters.json) -replace "AddGeography" , $regionName.ToLower() | Set-Content -Path \Dev\Repos\$adoRepo\AzureResources\azuredeploy.parameters.json

    Write-Host "Set new variables in Azure DevOps"
    az pipelines variable-group variable create --name CompanionAppName --value "$adoRepoLower-wba" --group-id $varGroup.id
    az pipelines variable-group variable create --name WebhookAppName --value "$adoRepoLower-fna" --group-id $varGroup.id
    az pipelines variable-group variable create --name d365AppSecurityRoleNames --value "Delegate" --group-id $varGroup.id

    az pipelines variable-group variable create --name CompanionAppName --value "$adoRepoLower-wba" --group-id $varGroupCICD.id
    az pipelines variable-group variable create --name WebhookAppName --value "$adoRepoLower-fna" --group-id $varGroupCICD.id
    az pipelines variable-group variable create --name d365AppSecurityRoleNames --value "Delegate" --group-id $varGroupCICD.id


    Set-Location -Path C:\Dev\Repos\$adoRepo\AzureResources\
    & .\Deploy-AzureResourceGroup.ps1 -ResourceGroupLocation $regionName -ResourceGroupName "$adoRepoLower-dev"
}

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



Welcome to the Power Platform DevOps provisioning script. This script will perform the following steps automatically :

 - Install the Pre-Requisites (git, NodeJS and Azure CLI) if required
 - Connect to Azure DevOps (You will need to have an Azure DevOps organisation to use, if you don't have one, please create one at https://dev.azure.com)
 - Allow you to Create a New Project in Azure DevOps or to Select an existing one
 - Create a New Git Repository in the Project to store your Source Code (and D365 / CDS Solutions and Data)
 - Clone this Template Repository into your new Azure DevOps repository
 - Clone your new repository locally to <root>\Dev\Repos
 - Create an Azure AD App Registration called "PowerApp Checker App" to enable PowerApp Solution Checker
 - Connect to your Power Platform tenant (You will need a Power Platform tenant, if you don't have one, please create one at https://powerapps.microsoft.com/)
 - Connect to your Power Platform Development Instance / Environment (If you don't have an instance to develop in, please create one at https://admin.powerplatform.microsoft.com)
    - You can either select an Existing Unamanged Solution (if you have already started customisation OR
    - Create a new Publisher and Solution
 - Connect to your Power Platform Deployment Instance (If you don't have an instance to Continuously Deploy to, please create one at https://admin.powerplatform.microsoft.com)
 - Update your Solution Version number
 - Export an Unmanaged and Managed version of your Solution
 - Unpack the Solutions with Solution Packager
 - Commit Solution to Source Control and sync to your Azure DevOps repo
 - Create an Azure DevOps Multi-Stage Pipeline to Build and Continuously Deploy your Code and Solutions
 - Create Variable Groups in Azure DevOps with your Power Platform details and credentials (stored as secrets)
 - Open the Repo and Pipeline in the Browser (and complete the initial Build and Deploy)       
 - Create new Azure ResourceGroup in your selected Azure Subscription

 ver. $Version

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
Install-PowerAppsAdmin

if ($PerformInstall)
{
    Install-DevOps
}
else {
    Confirm-DevOps-PreReq
}

