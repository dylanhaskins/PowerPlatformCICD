Param(
    [boolean] [Parameter(Mandatory = $false)] $PerformInstall = $false
)

function Restart-PowerShell
{
    Start-Sleep -Seconds 5
    refreshenv
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
    clear
    DevOps-Install
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

$adoOrg = Read-Host -Prompt "Enter the name of your Azure DevOps Organization (https://dev.azure.com/<Name>)"

az login --allow-no-subscriptions

Write-Host ""
$adoCreate = Read-Host -Prompt "Would you like to [C]reate a new Project or [S]elect and existing one (Default [S])"

if ($adoCreate -eq "C")
{
  $adoProject = Read-Host -Prompt "Please enter the Name of the Project you wish to Create"
  az devops project create --name $adoProject --process Scrum
}
else {
    $selection = az devops project list --organization=https://dev.azure.com/$adoOrg --query '[value][].{Name:name}' --output json | Out-String | ConvertFrom-Json
    $choiceIndex = 0
    $options = $selection | ForEach-Object { New-Object System.Management.Automation.Host.ChoiceDescription "&$($choiceIndex) - $($_.Name)"; $choiceIndex++ }
    $chosenIndex = $host.ui.PromptForChoice("DevOps Project", "Select the Project you wish to use", $options, 0)
    $adoProject = $selection[$chosenIndex].Name 

}

Write-Host ""
$adoRepo = Read-Host -Prompt "Enter the name for the Repository you wish to Create"

az devops configure --defaults organization=https://dev.azure.com/$adoOrg project=$adoProject

$repo = az repos create --name $adoRepo | Out-String | ConvertFrom-Json
az repos import create --git-source-url https://github.com/dylanhaskins/PowerPlatformCICD.git --repository $adoRepo

git clone $repo.webUrl

az repos show --repository $repo.id --open

$pipeline = az pipelines create --name "$adoRepo.CI" --yml-path /build.yaml --repository $adoRepo --repository-type tfsgit --branch master | ConvertFrom-Json
az pipelines show --id $pipeline.definition.id --open
}

$message = @"
____                          ____  _       _    __                        ____              ___            
|  _ \ _____      _____ _ __  |  _ \| | __ _| |_ / _| ___  _ __ _ __ ___   |  _ \  _____   __/ _ \ _ __  ___ 
| |_) / _ \ \ /\ / / _ \ '__| | |_) | |/ _` | __| |_ / _ \| '__| '_ ` _ \  | | | |/ _ \ \ / / | | | '_ \/ __|
|  __/ (_) \ V  V /  __/ |    |  __/| | (_| | |_|  _| (_) | |  | | | | | | | |_| |  __/\ V /| |_| | |_) \__ \
|_|   \___/ \_/\_/ \___|_|    |_|   |_|\__,_|\__|_|  \___/|_|  |_| |_| |_| |____/ \___| \_/  \___/| .__/|___/
                                                                                                  |_|        



Welcome to the Power Platform DevOps provisioning script. This script will install the Pre-Requisites (git and Azure CLI)

You will also need to have an Azure DevOps organisation to use, if you don't have one, please create one at https://dev.azure.com

You will need a Power Platform tenant, if you don't have one, please create one at https://powerapps.microsoft.com/


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

