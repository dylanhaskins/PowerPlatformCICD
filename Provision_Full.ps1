Param(
    [boolean] [Parameter(Mandatory = $false)] $PerformInstall = $false,
    [string] [Parameter(Mandatory = $false)] $Branch = "master"
)

$Text = "Power Platform DevOps"
$UniqueId = "PPDevOps"
$Version = "2.0.230620.1625"

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
    $moduleVersion = "2.8.8"
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
$moduleVersion = "2.0.66"
$module = Get-Module -ListAvailable -Name $moduleName
if (!($module.Version -ge $moduleVersion )) {
     Write-host "Module $moduleName version $moduleVersion or higher not found, installing now"
     Install-Module -Name $moduleName -MinimumVersion $moduleVersion -Force -AllowClobber
   }
   else
   {
     Write-host "Module $moduleName version $moduleVersion or higher Found"
   }
}

function Install-PowerAppsPowerShell{
$moduleName = "Microsoft.PowerApps.PowerShell"
$moduleVersion = "1.0.13"
$module = Get-Module -ListAvailable -Name $moduleName
if (!($module.Version -ge $moduleVersion )) {
     Write-host "Module $moduleName version $moduleVersion or higher not found, installing now"
     Install-Module -Name $moduleName -MinimumVersion $moduleVersion -Force -AllowClobber
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
$ProgressBar = New-BTProgressBar -Status $message -Value 0.30
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId


do{
    $adoOrg = Read-Host -Prompt "Enter the name of your Azure DevOps Organisation (https://dev.azure.com/<Name>)"
}until ($adoOrg -ne "")

$msg = "You will now be redirected to a Browser to Login to your Azure DevOps Organisation"
$title = "Setting up Azure DevOps"
$option0 = New-Object System.Management.Automation.Host.ChoiceDescription '&Continue', 'continue'
$option1 = New-Object System.Management.Automation.Host.ChoiceDescription '&Quit', 'quit'
$options = [System.Management.Automation.Host.ChoiceDescription[]]($option0, $option1)
$prompt_result = $host.ui.PromptForChoice($title, $msg, $options,-1)

if ($prompt_result -eq 1)
{
    Write-Host "Exiting setup"
    exit
}

$azSubs = az login --allow-no-subscriptions

Write-Host ""
[console]::ForegroundColor = "White"

$msg = "Select existing or Create a new Azure DevOps Project"
$title = "Setting up Azure DevOps"
$option0 = New-Object System.Management.Automation.Host.ChoiceDescription '&Select', 'select'
$option1 = New-Object System.Management.Automation.Host.ChoiceDescription '&Create', 'create'
$option2 = New-Object System.Management.Automation.Host.ChoiceDescription '&Quit', 'quit'
$options = [System.Management.Automation.Host.ChoiceDescription[]]($option0, $option1)
$prompt_result = $host.ui.PromptForChoice($title, $msg, $options,-1)

if($prompt_result -eq 2){
    exit
}

if ($prompt_result -eq 1)
{
    #add check for empty string


    do{
        $adoProject = Read-Host -Prompt "Please enter the Name of the Project you wish to Create"
	}until ($adoProject -ne "")
    

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
    $chosenIndex = $host.ui.PromptForChoice("DevOps Project", "Select the Project you wish to use", $options, -1)
    $adoProject = $selection[$chosenIndex].Name 
}

if ($adoCreate -eq 1)
{
    $adoRepo = $adoProject
    $adoRepo = $adoRepo.Replace(' ','')
    az devops configure --defaults organization=https://dev.azure.com/$adoOrg project=$adoProject
    $repo = az repos show --repository $adoRepo | Out-String | ConvertFrom-Json
}
else
{
    Write-Host ""

    do{
        $adoRepo = Read-Host -Prompt "Enter the name for the Git Repository you wish to Create"
    } until ($adoRepo -ne "")

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
$ProgressBar = New-BTProgressBar -Status $message -Value 0.70
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

$title = "Common Data Service"
$option0 = New-Object System.Management.Automation.Host.ChoiceDescription '&Connect', 'connect'
$option1 = New-Object System.Management.Automation.Host.ChoiceDescription '&Quit', 'quit'
$options = [System.Management.Automation.Host.ChoiceDescription[]]($option0, $option1)
$prompt_result = $host.ui.PromptForChoice($title, $message, $options,-1)

if ($quit -eq 1)
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

Write-Host "Updating Build.yaml ..."
(Get-Content -Path \Dev\Repos\$adoRepo\build.yaml) -replace "replaceRepo",$adoRepo | Set-Content -Path \Dev\Repos\$adoRepo\build.yaml
(Get-Content -Path \Dev\Repos\$adoRepo\build.yaml) -replace "AddName",$chosenSolution | Set-Content -Path \Dev\Repos\$adoRepo\build.yaml


Write-Host "Rename PowerPlatformDevOps.sln to $adoRepo.sln"
Rename-Item -Path \Dev\Repos\$adoRepo\PowerPlatformDevOps.sln -NewName "$adoRepo.sln"

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


