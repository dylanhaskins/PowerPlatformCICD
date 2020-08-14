Param(
    [string] [Parameter(Mandatory = $false)] $Branch = "master"
)

Clear-Host

do {
    $adoProject = Read-Host -Prompt "Please enter a Name for the Project you wish to Create"
}until ($adoProject -ne "")

$configFile = (Get-Content (Join-Path $PSScriptRoot "\devopsConfig.json") | ConvertFrom-Json)


Write-Host "Select a folder to create a new git Repository for your Power Platform Project"
Add-Type -AssemblyName System.Windows.Forms
$FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$FolderBrowser.Description = "Select a folder to create a new git Repository for your Power Platform Project"
[void]$FolderBrowser.ShowDialog()

if (!(Test-Path -Path "$($FolderBrowser.SelectedPath)\$adoProject")) {
    Write-Host "Creating Project Folder"
    New-Item -Path $FolderBrowser.SelectedPath -Name $adoProject -ItemType Directory
    Set-Location -Path "$($FolderBrowser.SelectedPath)\$adoProject"   

    $sourceFile = Invoke-WebRequest "https://raw.githubusercontent.com/dylanhaskins/PowerPlatformCICD/$branch/Install-PreRequisites.ps1" -UseBasicParsing:$true
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
    git branch -r | select-string -notmatch master | select-string -notmatch HEAD | ForEach-Object { git push origin --delete ("$_").Replace("origin/", "").Trim() } #Remove non-used branches from remote

    Remove-Item .git -Recurse -Force

    #& .\Provision_Full.ps1 -PerformInstall $PerformInstall -Branch $Branch -ErrorAction Stop
}
else {
    Write-Warning "The Path $($FolderBrowser.SelectedPath)\$adoProject already exists, please select a different path or project name"
    $continue = Read-Host -Prompt "Press [Enter] to Continue or [Q] to Quit"
    if (!$continue -eq 'Q') {
        . (Join-Path $PSScriptRoot .\Provision.ps1)        
    }
}





