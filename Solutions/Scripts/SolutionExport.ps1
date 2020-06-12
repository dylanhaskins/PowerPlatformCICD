Param(
    [boolean] [Parameter(Mandatory = $false)] $DevMode = $false,
    [string] [Parameter(Mandatory= $true)] $StartPath
)
######################## SETUP 
$ProgressPreference = 'SilentlyContinue'
Write-Host "Running for path : " $StartPath

. (Join-Path $PSScriptRoot "_SetupTools.ps1")
. (Join-Path $PSScriptRoot "_Config.ps1") -StartPath $StartPath

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
. (Join-Path $StartPath "_ConfigMigration.ps1")

######################## Generate Types
If ($DevMode)
{
. (Join-Path $PSScriptRoot "_GenerateTypes.ps1") -StartPath $StartPath
}

######################## UPDATE VERSION
. (Join-Path $PSScriptRoot "_UpdateVersion.ps1")

######################## EXPORT Solution
. (Join-Path $PSScriptRoot "_ExportSolution.ps1") -StartPath $StartPath -ErrorAction Stop

######################## UPDATE DEPENDENCIES
Write-Host Mapping Dependencies to deployPackage.json
$username =  $Credentials.GetNetworkCredential().UserName
$password =  $Credentials.GetNetworkCredential().Password
$mapper = (Join-Path $PSScriptRoot "\DependencyMapper\DependencyMapper.exe")
$params = "/UserName:$username /Password:$password /URL:$global:ServerUrl /Solution:$global:SolutionName"
Write-Host $mapper $params
#Start-Process -NoNewWindow -FilePath $mapper -ArgumentList $params


######################### CLEANING UP
$message = "Cleaning Up..."
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 1
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

Remove-Item (Join-Path $StartPath "nuget.exe") -ErrorAction Ignore -Force
Remove-Item (Join-Path $StartPath "Tools") -Force -Recurse -ErrorAction Ignore
Remove-Item (Join-Path $StartPath "*.zip") -Force -ErrorAction Ignore

 $ProgressPreference = 'Continue'
 Stop-Process -Id $PID



