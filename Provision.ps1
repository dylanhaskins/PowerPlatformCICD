Param(
    [string] [Parameter(Mandatory = $false)] $Branch = "master"
)

Clear-Host

$logo = @"
____                          ____  _       _    __                        ____              ___            
|  _ \ _____      _____ _ __  |  _ \| | __ _| |_ / _| ___  _ __ _ __ ___   |  _ \  _____   __/ _ \ _ __  ___ 
| |_) / _ \ \ /\ / / _ \ '__| | |_) | |/ _` | __| |_ / _ \| '__| '_ ` _ \  | | | |/ _ \ \ / / | | | '_ \/ __|
|  __/ (_) \ V  V /  __/ |    |  __/| | (_| | |_|  _| (_) | |  | | | | | | | |_| |  __/\ V /| |_| | |_) \__ \
|_|   \___/ \_/\_/ \___|_|    |_|   |_|\__,_|\__|_|  \___/|_|  |_| |_| |_| |____/ \___| \_/  \___/| .__/|___/
                                                                                                  |_|        

"@

$message = @"

Welcome to the Power Platform DevOps provisioning script. This script will perform the following steps automatically :

 - Install the Pre-Requisites (git, NodeJS and Azure CLI) if required
 - Clone this Template Repository locally
 - Allow you to Connect to Azure DevOps (You will need to have an Azure DevOps organisation to use, if you don't have one, please create one at https://dev.azure.com)
 - Allow you to Create a New Project in Azure DevOps or to Select an existing one
 - Create a New Git Repository in the Project to store your Source Code (and D365 / CDS Solutions and Data)
 - Allow you to Create an Azure AD App Registration called "PowerApp Checker App" to enable PowerApp Solution Checker
 - Allow you to Connect to your Power Platform tenant (You will need a Power Platform tenant, if you don't have one, please create one at https://powerapps.microsoft.com/)
 - Allow you to Connect to your Power Platform Development Instance / Environment (If you don't have an instance to develop in, please create one at https://admin.powerplatform.microsoft.com)
 - Allow you to Connect to your Power Platform Continuous Deployment Instance (If you don't have an instance to Continuously Deploy to, please create one at https://admin.powerplatform.microsoft.com)
 - Allow you to Create an Azure DevOps Multi-Stage Pipeline to Build and Continuously Deploy your Code and Solutions
 
 ver. $Version

"@

Write-Host $logo -ForegroundColor Magenta
Write-Host $message -ForegroundColor White

do {
    $gitRepo = Read-Host -Prompt "Please enter a Name for the Git Repository you wish to Create"
}until ($gitRepo -ne "")


Write-Host "Select a folder to create a new git Repository for your Power Platform Project"
try {
    $application = New-Object -ComObject Shell.Application
    $path = ($application.BrowseForFolder(0, 'Select a folder', 0)).Self.Path
    
    if (!(Test-Path -Path "$path\$gitRepo") -and !($null -eq $path)) {
        Write-Host "Creating Project Folder"
        New-Item -Path $path -Name $gitRepo -ItemType Directory
        Set-Location -Path "$path\$gitRepo"   
    
        $sourceFile = Invoke-WebRequest "https://raw.githubusercontent.com/dylanhaskins/PowerPlatformCICD/$branch/DevOpsFramework/Install-PreRequisites.ps1" -UseBasicParsing:$true
        Set-Content .\Install-PreRequisites.ps1 -Value $sourceFile.Content
    
        Start-Sleep -Seconds 2
        $message = "Checking Pre-requisites"
        Write-Host $message
    
        .\Install-PreRequisites.ps1 -ErrorAction Stop
    
        Remove-Item .\Install-PreRequisites.ps1 -Force -ErrorAction SilentlyContinue
        $message = "Cloning PowerPlatformCICD locally"
        Write-Host $message
    
        git clone https://github.com/dylanhaskins/PowerPlatformCICD.git .
    
        $message = "Confirming Git User Details"
        Write-Host $message
    
        $GitUser = git config --global user.name
        $GitEmail = git config --global user.email
    
        If ($null -eq $GitUser) {
            $GitUser = Read-Host "Enter your name (to use when committing changes to Git)"
            git config --global user.name $GitUser
        }
    
        If ($null -eq $GitEmail) {
            $GitEmail = Read-Host "Enter your email address (to use when committing changes to Git)"
            git config --global user.email $GitEmail
        }
    
        $message = "Cleaning up Git Repository"
        Write-Host $message
    
        git checkout $branch
        git branch | select-string -notmatch $branch | ForEach-Object { git branch -D ("$_").Trim() } #Remove non-used local branches    
    
        Remove-Item .git -Recurse -Force
    
        git init

        Write-Host "Updating Build.yaml ..."
        (Get-Content -Path $path\$gitRepo\build.yaml) -replace "replaceRepo", $gitRepo | Set-Content -Path $path\$gitRepo\build.yaml

        Write-Host "Rename PowerPlatformDevOps.sln to $gitRepo.sln"
        Rename-Item -Path $path\$gitRepo\PowerPlatformDevOps.sln -NewName "$gitRepo.sln"
    
        $configFile = (Get-Content "$path\$gitRepo\DevOpsFramework\devopsConfig.json" | ConvertFrom-Json)
        $configFile.gitRepo = $gitRepo
        $configFile.PreReqsComplete = "True"
        $configFile | ConvertTo-Json | Set-Content "$path\$gitRepo\DevOpsFramework\devopsConfig.json"
    
        & .\DevOpsFramework\Run-PowerPlatformDevOps.ps1 -Branch $Branch -ErrorAction Stop
    }
    else {
        Write-Warning "The Path $path\$gitRepo already exists, please select a different path or project name"
        $continue = Read-Host -Prompt "Press [Enter] to Continue or [Q] to Quit"
        if (!$continue -eq 'Q') {
            . (Join-Path $PSScriptRoot .\Provision.ps1)        
        }
    } 
}
catch {
    
}






