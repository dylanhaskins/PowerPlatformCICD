######################## SETUP 
$ProgressPreference = 'SilentlyContinue'
. (Join-Path $PSScriptRoot "_SetupTools.ps1")
. (Join-Path $PSScriptRoot "_Config.ps1")

$Text = $global:SolutionName
$UniqueId = "SolutionMGMT"

InstallToastModule
    $message = "Installing Solution Management Tools..."
    Write-Host $message
    $ProgressBar = New-BTProgressBar -Status $message -Value 0.05
    New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId


InstallXrmDataModule
InstallCoreTools
InstallDevOpsDataModule

######################## GET CONNECTION
if (!$Credentials) {
    $message = "Getting Credentials for $global:ServerUrl"
    Write-Host $message
    $ProgressBar = New-BTProgressBar -Status $message -Value 0.1
    New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

    $Credentials = Get-Credential -Message "Credentials : $global:SolutionName @ $global:ServerUrl"
}

    $message = "Establishing connection to $global:ServerUrl"
    Write-Host $message
    $ProgressBar = New-BTProgressBar -Status $message -Value 0.2
    New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId
    $conn = Connect-CrmOnline -Credential $Credentials -ServerUrl $global:ServerUrl


Write-Output($conn)

######################## Generate Config Migration data 
. (Join-Path $PSScriptRoot "_ConfigMigration.ps1")

######################## Generate Types
. (Join-Path $PSScriptRoot "_GenerateTypes.ps1")

######################## UPDATE VERSION
. (Join-Path $PSScriptRoot "_UpdateVersion.ps1")

######################## EXPORT Solution
. (Join-Path $PSScriptRoot "_ExportSolution.ps1")


######################### CLEANING UP
$message = "Cleaning Up..."
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 1
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

Remove-Item (Join-Path $PSScriptRoot "nuget.exe") -ErrorAction Ignore -Force
Remove-Item (Join-Path $PSScriptRoot "Tools") -Force -Recurse -ErrorAction Ignore
Remove-Item (Join-Path $PSScriptRoot "*.zip") -Force -ErrorAction Ignore

 $ProgressPreference = 'Continue'



