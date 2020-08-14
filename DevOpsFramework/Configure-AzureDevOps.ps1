. (Join-Path $PSScriptRoot "_SetupTools.ps1")

$configFile = Get-Content (Join-Path $PSScriptRoot "\devopsConfig.json") | ConvertFrom-Json
$Version = $configFile.Version
$adoOrg = $configFile.ADOOrgName
$adoProject = $configFile.ADOProject
$adoRepo = $configFile.gitRepo.Replace(' ', '')

function Install-DevOps {
    ## Install Azure DevOps Extension
    $message = "Installing azure-devops extenstion"
    Write-Host $message

    az extension add --name azure-devops

    $ErrorActionPreference = "SilentlyContinue"

    $message = "Connecting to Azure DevOps Organisation"


    do {
        Write-Host "Enter the <NAME> of your Azure DevOps Organisation only the NAME - not the full path!"
        $adoOrg = Read-Host -Prompt "Depending on your instance, either dev.azure.com/<NAME> or <NAME>.visualstudio.com"
    }until ($adoOrg -ne "")

    $configFile.ADOOrgName = $adoOrg
    $configFile | ConvertTo-Json | Set-Content (Join-Path $PSScriptRoot "\devopsConfig.json")

    $msg = "You will now be redirected to a Browser to Login to your Azure DevOps Organisation"
    $title = "Setting up Azure DevOps"
    $option0 = New-Object System.Management.Automation.Host.ChoiceDescription '&Continue', 'continue'
    $option1 = New-Object System.Management.Automation.Host.ChoiceDescription '&Quit', 'quit'
    $options = [System.Management.Automation.Host.ChoiceDescription[]]($option0, $option1)
    $prompt_result = $host.ui.PromptForChoice($title, $msg, $options, -1)

    if ($prompt_result -eq 1) {
        Write-Host "Exiting setup"
        exit
    }

    $azSubs = az login --allow-no-subscriptions

    Write-Host ""
    [console]::ForegroundColor = "White"

    if ($adoProject -eq "") {
        $msg = "Select existing or Create a new Azure DevOps Project"
        $title = "Setting up Azure DevOps"
        $option0 = New-Object System.Management.Automation.Host.ChoiceDescription '&Select', 'select'
        $option1 = New-Object System.Management.Automation.Host.ChoiceDescription '&Create', 'create'
        $option2 = New-Object System.Management.Automation.Host.ChoiceDescription '&Quit', 'quit'
        $options = [System.Management.Automation.Host.ChoiceDescription[]]($option0, $option1)
        $prompt_result = $host.ui.PromptForChoice($title, $msg, $options, -1)

        if ($prompt_result -eq 2) {
            exit
        }

        if ($prompt_result -eq 1) {
            do {
                $adoProject = Read-Host -Prompt "Please enter the Name of the Project you wish to Create"
            }until ($adoProject -ne "")
    
            $configFile.ADOProject = $adoProject            
    
            $message = "Creating DevOps Project $adoProject"
            Write-Host $message
            try {
                az devops project create --name $adoProject --organization=https://dev.azure.com/$adoOrg --process Scrum
                $adoCreate = $true
            }
            catch {
                $configFile.ADOConfigured = "Error"
            }
              
        }
        else {
            $selection = az devops project list --organization=https://dev.azure.com/$adoOrg --query '[value][].{Name:name}' --output json | Out-String | ConvertFrom-Json
            $choiceIndex = 0
            $options = $selection | ForEach-Object { New-Object System.Management.Automation.Host.ChoiceDescription "&$($choiceIndex) - $($_.Name)"; $choiceIndex++ }
            do {
                $chosenIndex = $host.ui.PromptForChoice("DevOps Project", "Select the Project you wish to use", $options, -1)
                $adoProject = $selection[$chosenIndex].Name 
            } until ($adoProject -ne "")
            $configFile.ADOProject = $adoProject  
        }
        $configFile | ConvertTo-Json | Set-Content (Join-Path $PSScriptRoot "\devopsConfig.json")
    }

    if (($adoRepo -eq $adoProject) -and $adoCreate) {
        az devops configure --defaults organization=https://dev.azure.com/$adoOrg project=$adoProject
        $repo = az repos show --repository $adoRepo | Out-String | ConvertFrom-Json
    }
    else {
        Write-Host ""

        $message = "Creating Git Repo $adoRepo"
        Write-Host $message

        az devops configure --defaults organization=https://dev.azure.com/$adoOrg project=$adoProject
        $repo = az repos create --name $adoRepo | Out-String | ConvertFrom-Json
    }

    git remote add origin $repo.webUrl

    git add -A
    git commit -m "Initial Commit"

}

try {
    Install-DevOps
    $configFile.ADOConfigured = "True"
    $configFile | ConvertTo-Json | Set-Content (Join-Path $PSScriptRoot "\devopsConfig.json")
}
catch {
    $configFile.ADOConfigured = "Error"
    $configFile | ConvertTo-Json | Set-Content (Join-Path $PSScriptRoot "\devopsConfig.json")
}