Param(
    [boolean] [Parameter(Mandatory = $false)] $PerformInstall = $false,
    [string] [Parameter(Mandatory = $false)] $branch = "master"
)

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
if (!(Get-Module -ListAvailable -Name $moduleName )) {
Write-host "Module $moduleName Not found, installing now"
Install-Module -Name $moduleName -MinimumVersion $moduleVersion -Force -Scope CurrentUser
}
else
{
Write-host "Module $moduleName Found"
}
}

function PreReq-Install
{
    Write-Host "Installing Chocolatey ...."
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
 
    Write-Host "Installing Git ...."
    choco install git.install -y

    Write-Host "Installing Azure CLI ...."
    choco install azure-cli -y -force

    ## Restart PowerShell Environment to Enable Azure CLI
    Restart-PowerShell
}

function DevOps-PreReq
{

$ErrorActionPreference = "SilentlyContinue"
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
az extension add --name azure-devops

$ErrorActionPreference = "SilentlyContinue"
Remove-Item AzureCli.msi

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

az devops configure --defaults organization=https://dev.azure.com/$adoOrg project=$adoProject

$repo = az repos create --name $adoRepo | Out-String | ConvertFrom-Json
az repos import create --git-source-url https://github.com/dylanhaskins/PowerPlatformCICD.git --repository $adoRepo

git clone $repo.webUrl \Dev\Repos\$adoRepo --single-branch --branch $branch

Write-Host "Create PowerApps Check Azure AD Application"
$manifest = Invoke-WebRequest "https://github.com/dylanhaskins/PowerPlatformCICD/raw/$branch/manifest.json"
Set-Content .\manifest.json -Value $manifest.Content

$adApp = az ad app create --display-name "PowerApp Checker App" --native-app --required-resource-accesses manifest.json --reply-urls "urn:ietf:wg:oauth:2.0:oob" | ConvertFrom-Json
$azureADAppPassword = (New-Guid).Guid.Replace("-","")
$adAppCreds = az ad app credential reset --password $azureADAppPassword --id $adApp.appId | ConvertFrom-Json

chdir -Path \Dev\Repos\$adoRepo\Solutions\Scripts\Manual

Write-Host ""
Write-Host ""
$quit = Read-Host -Prompt "Press Enter to Connect to your CDS / D365 Tenant or [Q]uit"
if ($quit -eq "Q")
{
    exit
}

InstallXrmModule

if (!$Credentials)
{
	$Credentials = Get-Credential
}
if (!$username)
{
$username =  $Credentials.GetNetworkCredential().UserName
$password =  $Credentials.GetNetworkCredential().Password
}

    Write-Host ""
    Write-Host "---- Please Select your Development Environment ------"
    $conn = Connect-CrmOnlineDiscovery -Credential $Credentials

    $CreateOrSelect = Read-Host -Prompt "Development Environment : Would you like to [C]reate a New Solution or [S]elect an Existing One (Default [S])"
if ($CreateOrSelect -eq "C"){
    $PublisherName = Read-Host -Prompt "Enter a Name for your Solution Publisher"
    $PublisherPrefix = Read-Host -Prompt "Enter a Publisher Prefix"

    $PublisherId = New-CrmRecord -EntityLogicalName publisher -Fields @{"uniquename"=$PublisherName.Replace(' ','').ToLower();"friendlyname"=$PublisherName;"customizationprefix"=$PublisherPrefix}

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
    $options = $solutions | ForEach-Object { New-Object System.Management.Automation.Host.ChoiceDescription "&$($choiceIndex) - $($_.uniquename)"; $choiceIndex++ }
    $chosenIndex = $host.ui.PromptForChoice("Solution", "Select the Solution you wish to use", $options, 0)
    $chosenSolution = $solutions[$chosenIndex].uniquename
}
#}

Write-Host "Updating config.json ..."

(Get-Content -Path \Dev\Repos\$adoRepo\Solutions\Scripts\config.json) -replace "https://AddName.crm6.dynamics.com",$conn.ConnectedOrgPublishedEndpoints["WebApplication"] | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\Scripts\config.json
(Get-Content -Path \Dev\Repos\$adoRepo\Solutions\Scripts\config.json) -replace "AddName",$chosenSolution | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\Scripts\config.json

Write-Host "Updating ImportConfig.xml ..."

(Get-Content -Path \Dev\Repos\$adoRepo\PackageDeployer\PkgFolder\ImportConfig.xml) -replace "AddName",$chosenSolution | Set-Content -Path \Dev\Repos\$adoRepo\PackageDeployer\PkgFolder\ImportConfig.xml

Write-Host "Updating Build.yaml ..."

(Get-Content -Path \Dev\Repos\$adoRepo\build.yaml) -replace "replaceRepo",$adoRepo | Set-Content -Path \Dev\Repos\$adoRepo\build.yaml
(Get-Content -Path \Dev\Repos\$adoRepo\build.yaml) -replace "replaceBranch",$branch | Set-Content -Path \Dev\Repos\$adoRepo\build.yaml
(Get-Content -Path \Dev\Repos\$adoRepo\build.yaml) -replace "AddName",$chosenSolution | Set-Content -Path \Dev\Repos\$adoRepo\build.yaml

Write-Host "Updating XrmContext.exe.config ..."

(Get-Content -Path \Dev\Repos\$adoRepo\Solutions\XrmContext\XrmContext.exe.config) -replace "AddName",$chosenSolution | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\XrmContext\XrmContext.exe.config

Write-Host "Updating XrmDefinitelyTyped.exe.config ..."

(Get-Content -Path \Dev\Repos\$adoRepo\Solutions\XrmDefinitelyTyped\XrmDefinitelyTyped.exe.config) -replace "AddName",$chosenSolution | Set-Content -Path \Dev\Repos\$adoRepo\Solutions\XrmDefinitelyTyped\XrmDefinitelyTyped.exe.config

Write-Host ""
Write-Host "---- Please Select your Deployment Staging (CI/CD) Environment ------"
$connCICD = Connect-CrmOnlineDiscovery -Credential $Credentials

& ".\\SolutionExport.ps1"

git add -A
git commit -m "Initial Commit"
git push origin $branch


$varGroup = az pipelines variable-group create --name "$adoRepo.D365DevEnvironment"  --variables d365username=$username --authorize $true | ConvertFrom-Json
az pipelines variable-group variable create --name d365password --value $password --secret $true --group-id $varGroup.id
az pipelines variable-group variable create --name d365url --value $conn.ConnectedOrgPublishedEndpoints["WebApplication"]  --group-id $varGroup.id

$varGroupCICD = az pipelines variable-group create --name "$adoRepo.D365CDEnvironment"  --variables d365username=$username --authorize $true| ConvertFrom-Json
az pipelines variable-group variable create --name d365password --value $password --secret $true --group-id $varGroupCICD.id
az pipelines variable-group variable create --name aadTenant --value $adAppCreds.tenant --group-id $varGroupCICD.id
az pipelines variable-group variable create --name aadPowerAppId --value $adAppCreds.appId --group-id $varGroupCICD.id
az pipelines variable-group variable create --name aadPowerAppSecret --value $adAppCreds.password --secret $true --group-id $varGroupCICD.id
az pipelines variable-group variable create --name d365url --value $connCICD.ConnectedOrgPublishedEndpoints["WebApplication"]  --group-id $varGroupCICD.id

$pipeline = az pipelines create --name "$adoRepo.CI" --yml-path /build.yaml --repository $adoRepo --repository-type tfsgit --branch master | ConvertFrom-Json

az repos show --repository $repo.id --open
az pipelines show --id $pipeline.definition.id --open
}

$sourceFile = Invoke-WebRequest "https://github.com/dylanhaskins/PowerPlatformCICD/raw/$branch/Provision.ps1"
Set-Content .\Provision.ps1 -Value $sourceFile.Content


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


"@

Write-Host $message

$quit = Read-Host -Prompt "Press Enter to Continue or [Q]uit"
if ($quit -eq "Q")
{
    exit
}

if ($PerformInstall)
{
    DevOps-Install
}
else {
    DevOps-PreReq
}

