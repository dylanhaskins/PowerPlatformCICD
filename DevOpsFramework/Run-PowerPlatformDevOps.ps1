function Set-Colour(
    [string]$value
) {
    if ($value -eq "False") { 
        return "White" 
    } 
    elseif ($value -eq "Error") {
        return "Red"
    }
    elseif ($value -eq "Optional") {
        return "Magenta"
    }
    else { return "Green" }
}

$configFile = Get-Content (Join-Path $PSScriptRoot "\devopsConfig.json") | ConvertFrom-Json
$Version = $configFile.Version

$logo = @"
____                          ____  _       _    __                        ____              ___            
|  _ \ _____      _____ _ __  |  _ \| | __ _| |_ / _| ___  _ __ _ __ ___   |  _ \  _____   __/ _ \ _ __  ___ 
| |_) / _ \ \ /\ / / _ \ '__| | |_) | |/ _` | __| |_ / _ \| '__| '_ ` _ \  | | | |/ _ \ \ / / | | | '_ \/ __|
|  __/ (_) \ V  V /  __/ |    |  __/| | (_| | |_|  _| (_) | |  | | | | | | | |_| |  __/\ V /| |_| | |_) \__ \
|_|   \___/ \_/\_/ \___|_|    |_|   |_|\__,_|\__|_|  \___/|_|  |_| |_| |_| |____/ \___| \_/  \___/| .__/|___/
                                                                                                  |_|        

"@

$message = @"

Welcome to the Power Platform DevOps configuration script.

 ver. $Version

"@

function Show-Menu {
    param (
        [string]$Title = 'Power Platform DevOps'
    )
    $configFile = Get-Content (Join-Path $PSScriptRoot "\devopsConfig.json") | ConvertFrom-Json
    $devopsConfigMessage = "(ADO Org : $($configFile.ADOOrgName) | ADO Project : $($configFile.ADOProject) | git Repo : $($configFile.gitRepo))"
    $CICDConfigMessage = "(Continuous Deployment Environment : $($configFile.CICDEnvironment))"
    [console]::ForegroundColor = "White"
    Clear-Host
    Write-Host $logo -ForegroundColor Magenta
    Write-Host $message -ForegroundColor White
    $Repeater = "=" * $Title.Length
    Write-Host "================ $Title ================" -ForegroundColor White
    
    Write-Host "1: Run Pre-requisite checks (Install / Update)." -ForegroundColor (Set-Colour $configFile.PreReqsComplete)
    Write-Host "2: Configure Azure DevOps" $devopsConfigMessage -ForegroundColor (Set-Colour $configFile.ADOConfigured)
    Write-Host "3: Configure Continuous Deployment" $CICDConfigMessage -ForegroundColor (Set-Colour $configFile.CICDEnvironmentName)
    Write-Host "4: Add New D365 / CDS Solution." -ForegroundColor (Set-Colour $configFile.SolutionAdded)
    Write-Host "5: Enable Azure Resource Management Deployment." -ForegroundColor (Set-Colour $configFile.ARMAdded)
    Write-Host "6: Add Webhooks Project." -ForegroundColor (Set-Colour $configFile.WebHooksAdded)
    Write-Host "Q: Press 'Q' to quit." -ForegroundColor White
    Write-Host "=================$Repeater=================" -ForegroundColor White
}

function Install-PreReqs {
    $message = "Checking Pre-requisites"
    Write-Host $message

    try {
        . (Join-Path $PSScriptRoot Install-PreRequisites.ps1)     
        $configFile.PreReqsComplete = "True"
    }
    catch {
        $configFile.PreReqsComplete = "Error"
    }
    $configFile | ConvertTo-Json | Set-Content (Join-Path $PSScriptRoot "\devopsConfig.json")
   
}

function Connect-AzureDevOps {
    $message = "Configuring Azure DevOps"
    Write-Host $message

    try {
        . (Join-Path $PSScriptRoot Configure-AzureDevOps.ps1)     
        $configFile.PreReqsComplete = "True"
    }
    catch {
        $configFile.PreReqsComplete = "Error"
    }
    $configFile | ConvertTo-Json | Set-Content (Join-Path $PSScriptRoot "\devopsConfig.json")
   
}

function Add-Solution {
    $message = "Adding D365 / CDS Solution"
    Write-Host $message

    try {
        . (Join-Path $PSScriptRoot Add-Solution.ps1)     
        $configFile.SolutionAdded = "True"
    }
    catch {
        $configFile.SolutionAdded = "Error"
    }
    $configFile | ConvertTo-Json | Set-Content (Join-Path $PSScriptRoot "\devopsConfig.json")
   
}



Write-Host ""
[console]::ForegroundColor = "White"

do {
    Show-Menu

    $selection = Read-Host "Please make a selection (Purple items are optional)"
    switch ($selection) {
        '1' {
            Install-PreReqs
        } '2' {
            Connect-AzureDevOps
        } '4' {
            Add-Solution    
        }
    }   
    Write-Host ""
}
until ($selection -eq 'q')