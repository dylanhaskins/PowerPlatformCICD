Param(
    [boolean] [Parameter(Mandatory = $false)] $PerformInstall = $false,
    [string] [Parameter(Mandatory = $false)] $Branch = "master"
)

$Text = "Power Platform DevOps"
$UniqueId = "PPDevOps"

function Restart-PowerShell
{
    Start-Sleep -Seconds 5
    refreshenv
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
    clear
    DevOps-Install
}

function InstallXrmModule{
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

Function InstallToastModule{
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

function InstallPowerAppsAdmin{
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

function InstallPowerAppsPowerShell{
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

function PreReq-Install
{
    $message = "Installing Chocolatey ...."
    Write-Host $message
    $ProgressBar = New-BTProgressBar -Status $message -Value 0.12
    New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
 
    $message = "Installing Git ...."
    Write-Host $message
    $ProgressBar = New-BTProgressBar -Status $message -Value 0.15
    New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

    choco install git.install -y

    
    $message = "Installing Azure CLI ...."
    Write-Host $message
    $ProgressBar = New-BTProgressBar -Status $message -Value 0.18
    New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId
    choco install azure-cli -y -force

    ## Restart PowerShell Environment to Enable Azure CLI
    Restart-PowerShell
}

function DevOps-PreReq
{

$ErrorActionPreference = "SilentlyContinue"

$message = "Checking Azure CLI"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.1
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

$azver = az --version

if ($azver)
{
    if ($azver[$azver.Length -3] -eq "Your CLI is up-to-date.")
    {
        $ErrorActionPreference = "Continue"
        DevOps-Install
    }
    else {
        PreReq-Install
    }
}
else {
    $ErrorActionPreference = "Continue"
    PreReq-Install
     }
}

function DevOps-Install
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

az login --allow-no-subscriptions

Write-Host ""
$adoCreate = Read-Host -Prompt "Would you like to [C]reate a new Project or [S]elect and existing one (Default [S])"

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

Write-Host ""
$adoRepo = Read-Host -Prompt "Enter the name for the Git Repository you wish to Create"
$adoRepo = $adoRepo.Replace(' ','')

$message = "Creating Git Repo $adoRepo"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.38
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

az devops configure --defaults organization=https://dev.azure.com/$adoOrg project=$adoProject

$repo = az repos create --name $adoRepo | Out-String | ConvertFrom-Json
az repos import create --git-source-url https://github.com/dylanhaskins/PowerPlatformCICD.git --repository $adoRepo

$message = "Cloning Git Repo $adoRepo locally"
Write-Host $message
Write-Host "If prompted for credentials, enter the same credentials you used for dev.azure.com"
$ProgressBar = New-BTProgressBar -Status $message -Value 0.40
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

git clone $repo.webUrl \Dev\Repos\$adoRepo 

$message = "Create PowerApps Check Azure AD Application"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.50
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

$manifest = Invoke-WebRequest "https://github.com/dylanhaskins/PowerPlatformCICD/raw/$branch/manifest.json" -UseBasicParsing:$true
Set-Content .\manifest.json -Value $manifest.Content

$adApp = az ad app create --display-name "PowerApp Checker App" --native-app --required-resource-accesses manifest.json --reply-urls "urn:ietf:wg:oauth:2.0:oob" | ConvertFrom-Json
$azureADAppPassword = (New-Guid).Guid.Replace("-","")
$adAppCreds = az ad app credential reset --password $azureADAppPassword --id $adApp.appId | ConvertFrom-Json

chdir -Path \Dev\Repos\$adoRepo\

$message = "Confirming Git User Details"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.59
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

$GitUser = git config --global user.name
$GitEmail = git config --global user.email

If ($GitUser -eq $null){
    $GitUser = Read-Host "Enter your name (to use when committing changes to Git)"
    git config --global user.name $GitUser
}

If ($GitEmail -eq $null){
    $GitEmail = Read-Host "Enter your email address (to use when committing changes to Git)"
    git config --global user.email $GitEmail
}



$message = "Cleaning up Git Repository"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.60
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

git checkout $branch
git branch | select-string -notmatch $branch | foreach {git branch -D ("$_").Trim()} #Remove non-used local branches
git branch -r | select-string -notmatch master | select-string -notmatch HEAD | foreach { git push origin --delete ("$_").Replace("origin/","").Trim()} #Remove non-used branches from remote

Remove-Item .git -Recurse -Force
git init
git add .
git remote add origin $repo.webUrl

chdir -Path \Dev\Repos\$adoRepo\Solutions\Scripts\Manual

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

    Add-PowerAppsAccount -Username $Credentials.UserName -Password $Credentials.Password

    $Locations = Get-AdminPowerAppEnvironmentLocations

    $choiceIndex = 0
    $options = $Locations | ForEach-Object { write-Host "[$($choiceIndex)] $($_.LocationDisplayName)"; $choiceIndex++; }
    $geoselect = Read-Host "Please select the Geography for your Power Platform "
    $Geography = $Locations[$geoselect].LocationName

    InstallXrmModule

    $message = "Connecting to Development Environment"
    Write-Host $message
    $ProgressBar = New-BTProgressBar -Status $message -Value 0.75
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

    $PublisherName = Read-Host -Prompt "Enter a Name for your Solution Publisher"
    $PublisherPrefix = Read-Host -Prompt "Enter a Publisher Prefix"

    $PublisherId = New-CrmRecord -EntityLogicalName publisher -Fields @{"uniquename"=$PublisherName.Replace(' ','').ToLower();"friendlyname"=$PublisherName;"customizationprefix"=$PublisherPrefix.Replace(' ','').ToLower()}

    $SolutionName = Read-Host -Prompt "Enter a Name for your Unmanaged Development Solution"
    $PubLookup = New-CrmEntityReference -EntityLogicalName publisher -Id $PublisherId.Guid
    $SolutionId = New-CrmRecord -EntityLogicalName solution -Fields @{"uniquename"=$SolutionName.Replace(' ','').ToLower();"friendlyname"=$SolutionName;"version"="1.0.0.0";"publisherid"=$PubLookup}
    $chosenSolution = $SolutionName.Replace(' ','').ToLower()
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
#}

$message = "Setting Configurations in Source Code"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.80
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

Write-Host "Updating config.json ..."
(Get-Content -Path \Dev\Repos\$adoRepo\Solutions\Scripts\config.json) -replace "https://AddName.crm6.dynamics.com",$conn.ConnectedOrgPublishedEndpoints["WebApplication"] | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\Scripts\config.json
(Get-Content -Path \Dev\Repos\$adoRepo\Solutions\Scripts\config.json) -replace "AddName",$chosenSolution | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\Scripts\config.json
(Get-Content -Path \Dev\Repos\$adoRepo\Solutions\Scripts\config.json) -replace "AddGeography",$Geography | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\Scripts\config.json

Write-Host "Updating spkl.json ..."
(Get-Content -Path \Dev\Repos\$adoRepo\Solutions\spkl.json) -replace "AddName",$chosenSolution | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\spkl.json
(Get-Content -Path \Dev\Repos\$adoRepo\Solutions\spkl.json) -replace "prefix",$PublisherPrefix.Replace(' ','').ToLower() | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\spkl.json

Write-Host "Updating ImportConfig.xml ..."
(Get-Content -Path \Dev\Repos\$adoRepo\PackageDeployer\PkgFolder\ImportConfig.xml) -replace "AddName",$chosenSolution | Set-Content -Path \Dev\Repos\$adoRepo\PackageDeployer\PkgFolder\ImportConfig.xml

Write-Host "Updating Build.yaml ..."
(Get-Content -Path \Dev\Repos\$adoRepo\build.yaml) -replace "replaceRepo",$adoRepo | Set-Content -Path \Dev\Repos\$adoRepo\build.yaml
(Get-Content -Path \Dev\Repos\$adoRepo\build.yaml) -replace "AddName",$chosenSolution | Set-Content -Path \Dev\Repos\$adoRepo\build.yaml

Write-Host "Updating XrmContext.exe.config ..."
(Get-Content -Path \Dev\Repos\$adoRepo\Solutions\XrmContext\XrmContext.exe.config) -replace "AddName",$chosenSolution | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\XrmContext\XrmContext.exe.config

Write-Host "Updating XrmDefinitelyTyped.exe.config ..."
(Get-Content -Path \Dev\Repos\$adoRepo\Solutions\XrmDefinitelyTyped\XrmDefinitelyTyped.exe.config) -replace "AddName",$chosenSolution | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\XrmDefinitelyTyped\XrmDefinitelyTyped.exe.config

Write-Host "Updating Companion App Settings"
(Get-Content -Path \Dev\Repos\$adoRepo\PortalCompanionApp\AppSettings.json) -replace "https://AddName.crm6.dynamics.com",$conn.ConnectedOrgPublishedEndpoints["WebApplication"] | Set-Content -Path \Dev\Repos\$adoRepo\PortalCompanionApp\AppSettings.json

Write-Host "Updating Webhook Settings"
(Get-Content -Path \Dev\Repos\$adoRepo\Webhook\local.settings.json) -replace "https://AddName.crm6.dynamics.com",$conn.ConnectedOrgPublishedEndpoints["WebApplication"] | Set-Content -Path \Dev\Repos\$adoRepo\Webhook\local.settings.json

Write-Host "Rename PowerPlatformDevOps.sln to $adoRepo.sln"
Rename-Item -Path \Dev\Repos\$adoRepo\PowerPlatformDevOps.sln -NewName "$adoRepo.sln"
(Get-Content -Path \Dev\Repos\$adoRepo\Plugins\Plugins.csproj) -replace "PowerPlatformDevOpsPlugins",($adoRepo+"Plugins") | Set-Content -Path \Dev\Repos\$adoRepo\Plugins\Plugins.csproj
(Get-Content -Path \Dev\Repos\$adoRepo\Solutions\map.xml) -replace "PowerPlatformDevOpsPlugins",($adoRepo+"Plugins") | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\map.xml
(Get-Content -Path \Dev\Repos\$adoRepo\Workflows\Workflows.csproj) -replace "PowerPlatformDevOpsWorkflows",($adoRepo+"Workflows") | Set-Content -Path \Dev\Repos\$adoRepo\Workflows\Workflows.csproj
(Get-Content -Path \Dev\Repos\$adoRepo\Solutions\map.xml) -replace "PowerPlatformDevOpsWorkflows",($adoRepo+"Workflows") | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\map.xml


$message = "Connecting to Deployment Staging (CI/CD)"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.85
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

Write-Host ""
Write-Host "---- Please Select your Deployment Staging (CI/CD) Environment ------"
$connCICD = Connect-CrmOnlineDiscovery -Credential $Credentials

& ".\\SolutionExport.ps1"

git add -A
git commit -m "Initial Commit"
git push origin master --force

$message = "Creating variable groups in Azure DevOps"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.90
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

$varGroup = az pipelines variable-group create --name "$adoRepo.D365DevEnvironment"  --variables d365username=$username --authorize $true | ConvertFrom-Json
az pipelines variable-group variable create --name d365password --value $password --secret $true --group-id $varGroup.id
az pipelines variable-group variable create --name d365url --value $conn.ConnectedOrgPublishedEndpoints["WebApplication"]  --group-id $varGroup.id

$varGroupCICD = az pipelines variable-group create --name "$adoRepo.D365CDEnvironment"  --variables d365username=$username --authorize $true| ConvertFrom-Json
az pipelines variable-group variable create --name d365password --value $password --secret $true --group-id $varGroupCICD.id
az pipelines variable-group variable create --name aadTenant --value $adAppCreds.tenant --group-id $varGroupCICD.id
az pipelines variable-group variable create --name aadPowerAppId --value $adAppCreds.appId --group-id $varGroupCICD.id
az pipelines variable-group variable create --name aadPowerAppSecret --value $adAppCreds.password --secret $true --group-id $varGroupCICD.id
az pipelines variable-group variable create --name d365url --value $connCICD.ConnectedOrgPublishedEndpoints["WebApplication"]  --group-id $varGroupCICD.id

$message = "Creating Build and Deploy Pipeline in Azure DevOps"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.95
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

$pipeline = az pipelines create --name "$adoRepo.CI" --yml-path /build.yaml --repository $adoRepo --repository-type tfsgit --branch master | ConvertFrom-Json

az repos show --repository $repo.id --open
az pipelines show --id $pipeline.definition.id --open


#add azure provisioning here
#need to update library in DevOps with Keyvault, Storage etc values


Write-Host "Setting up the Azure Resource group requires both Azure and your Power Platform/Dynamics 365 to be on the same Azure AD Tenant"
$AzureSetup = Read-Host -Prompt "Azure subscriptions : Would you like to create the default Azure resources [Y] Yes or [S] Skip (Default [S])"

if ($AzureSetup -eq "Y"){

Login-AzureRmAccount

    $selection =  az account list --output json | Out-String | ConvertFrom-Json
    $choiceIndex = 0
    $options = $selection | ForEach-Object { New-Object System.Management.Automation.Host.ChoiceDescription "&$($choiceIndex) - $($_.Name)"; $choiceIndex++ }
    $chosenIndex = $host.ui.PromptForChoice("Azure subscription", "Select the Azure Subscription you want to deploy to", $options, 0)
    $subscriptionName = $selection[$chosenIndex].name 
       
Write-Host "Selected Subscription : $subscriptionName"
Select-AzureRmSubscription -Subscription $subscriptionName

    $selection =  az account list-locations --output json | Out-String | ConvertFrom-Json
    $choiceIndex = 0    
    $choices = @()
    $options = $selection | ForEach-Object { New-Object System.Management.Automation.Host.ChoiceDescription "&$($choiceIndex) - $($_.Name)"; $choiceIndex++ }
    $chosenIndex = $host.ui.PromptForChoice("Azure Region", "Select the Azure Region you want to use", $options, 0)
    $regionName = $selection[$chosenIndex].Name 

Write-Host "Selected Region : $regionName"

Write-Host "Updating ARM Parameters"
(Get-Content -Path \Dev\Repos\$adoRepo\AzureResources\azuredeploy.parameters.json) -replace "AddName" , $adoRepo | Set-Content -Path \Dev\Repos\$adoRepo\AzureResources\azuredeploy.parameters.json
(Get-Content -Path \Dev\Repos\$adoRepo\AzureResources\azuredeploy.parameters.json) -replace "AddGeography" , $regionName.ToLower() | Set-Content -Path \Dev\Repos\$adoRepo\AzureResources\azuredeploy.parameters.json

chdir -Path C:\Dev\Repos\$adoRepo\AzureResources\
& .\Deploy-AzureResourceGroup.ps1 -ResourceGroupLocation $regionName -ResourceGroupName "$adoRepo-dev"
}

Write-Host "Set new variables in Azure DevOps"
az pipelines variable-group variable create --name CompanionAppName --value "$adoRepo-wba" --group-id $varGroup.id
az pipelines variable-group variable create --name WebhookAppName --value "$adoRepo-fna" --group-id $varGroup.id
az pipelines variable-group variable create --name d365AppSecurityRoleNames --value "Delegate" --group-id $varGroup.id

az pipelines variable-group variable create --name CompanionAppName --value "$adoRepo-wba" --group-id $varGroupCICD.id
az pipelines variable-group variable create --name WebhookAppName --value "$adoRepo-fna" --group-id $varGroupCICD.id
az pipelines variable-group variable create --name d365AppSecurityRoleNames --value "Delegate" --group-id $varGroupCICD.id

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

 - Install the Pre-Requisites (git and Azure CLI) if required
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


"@

Write-Host $message

$quit = Read-Host -Prompt "Press Enter to Continue or [Q]uit"
if ($quit -eq "Q")
{
    exit
}
    
Write-Host("Performing Checks....")
InstallToastModule
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
InstallPowerAppsAdmin

if ($PerformInstall)
{
    DevOps-Install
}
else {
    DevOps-PreReq
}

