Param(
    [boolean] [Parameter(Mandatory = $false)] $PerformInstall = $false,
    [string] [Parameter(Mandatory = $false)] $Branch = "master"
)

function Install-DevOps
{


$message = "Creating variable groups in Azure DevOps"
Write-Host $message

$varGroup = az pipelines variable-group create --name "$adoRepo.D365DevEnvironment"  --variables d365username=$username --authorize $true | ConvertFrom-Json
az pipelines variable-group variable create --name d365password --value $password --secret $true --group-id $varGroup.id
az pipelines variable-group variable create --name d365url --value "To Be Configured"  --group-id $varGroup.id

$varGroupTest = az pipelines variable-group create --name "$adoRepo.D365TestEnvironment"  --variables d365username=$username --authorize $true| ConvertFrom-Json
az pipelines variable-group variable create --name d365password --value $password --secret $true --group-id $varGroupTest.id
az pipelines variable-group variable create --name d365url --value "To Be Configured"  --group-id $varGroupTest.id



$message = "Complete ... Enjoy !!!"
Write-Host $message
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
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-PowerAppsAdmin

if ($PerformInstall)
{
    Install-DevOps
}
else {
    Confirm-DevOps-PreReq
}


