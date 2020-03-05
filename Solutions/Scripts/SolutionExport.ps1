######################## SETUP 
.  ".\_SetupTools.ps1"
.  ".\_Config.ps1"

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
if (!$conn) {
    $message = "Establishing connection to $global:ServerUrl"
    Write-Host $message
    $ProgressBar = New-BTProgressBar -Status $message -Value 0.2
    New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId
    $conn = Connect-CrmOnline -Credential $Credentials -ServerUrl $global:ServerUrl
}

Write-Output($conn)

######################## Generate Config Migration data 
& ".\_ConfigMigration.ps1"

######################## Generate Types
& ".\_GenerateTypes.ps1"

######################## UPDATE VERSION
& ".\_UpdateVersion.ps1"

######################## EXPORT Solution
& ".\_ExportSolution.ps1"


######################### CLEANING UP
$message = "Cleaning Up..."
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 1
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

Remove-Item nuget.exe
Remove-Item .\Tools -Force -Recurse -ErrorAction Ignore



