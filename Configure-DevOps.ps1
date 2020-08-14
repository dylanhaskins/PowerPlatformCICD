$Version = (Get-Content (Join-Path $PSScriptRoot "\devopsConfig.json") | ConvertFrom-Json).Version

$message = @"
____                          ____  _       _    __                        ____              ___            
|  _ \ _____      _____ _ __  |  _ \| | __ _| |_ / _| ___  _ __ _ __ ___   |  _ \  _____   __/ _ \ _ __  ___ 
| |_) / _ \ \ /\ / / _ \ '__| | |_) | |/ _` | __| |_ / _ \| '__| '_ ` _ \  | | | |/ _ \ \ / / | | | '_ \/ __|
|  __/ (_) \ V  V /  __/ |    |  __/| | (_| | |_|  _| (_) | |  | | | | | | | |_| |  __/\ V /| |_| | |_) \__ \
|_|   \___/ \_/\_/ \___|_|    |_|   |_|\__,_|\__|_|  \___/|_|  |_| |_| |_| |____/ \___| \_/  \___/| .__/|___/
                                                                                                  |_|        



Welcome to the Power Platform DevOps configuration script.

 ver. $Version

"@

function Show-Menu {
    param (
        [string]$Title = 'Power Platform DevOps'
    )
    Clear-Host
    Write-Host $message
    $Repeater = "=" * $Title.Length
    Write-Host "================ $Title ================"
    
    Write-Host "1: Run Pre-requisite checks (Install / Update)."
    Write-Host "2: Add New D365 / CDS Solution."
    Write-Host "3: Enable Azure Resource Management Deployment."
    Write-Host "4: Add Webhooks Project."
    Write-Host "Q: Press 'Q' to quit."
    Write-Host "=================$Repeater================="
}

function Install-PreReqs
{
    $message = "Checking Pre-requisites"
    Write-Host $message

    . (Join-Path $PSScriptRoot Install-PreRequisites.ps1)
}



Write-Host ""
[console]::ForegroundColor = "White"

do
 {
    Show-Menu
    $selection = Read-Host "Please make a selection"
    switch ($selection)
    {
    '1' {
    Install-PreReqs
    } '2' {
    'You chose option #2'
    } '3' {
      'You chose option #3'
    }
    }   
    Write-Host ""
 }
 until ($selection -eq 'q')