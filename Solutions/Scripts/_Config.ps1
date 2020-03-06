
######################## VARIABLES 
#$global:ServerUrl = "https://AddNameHere.crm6.dynamics.com"
#$global:SolutionName = "AddNameHere"
#$global:UnmanagedPackageFile = "AddNameHere.zip"
#$global:ManagedPackageFile = "AddNameHere_managed.zip"

$global:BaseConfig = Join-Path $PSScriptRoot "config.json"

# Load and parse the JSON configuration file
try {
	$global:Config = Get-Content "$BaseConfig" -Raw -ErrorAction:SilentlyContinue -WarningAction:SilentlyContinue | ConvertFrom-Json -ErrorAction:SilentlyContinue -WarningAction:SilentlyContinue
} catch {
	Write-PoshError -Message "The Base configuration file is missing!" -Stop
}

# Check the configuration
if (!($Config)) {
	Write-PoshError -Message "The Base configuration file is missing!" -Stop
}


$global:ServerUrl = ($Config.target.ServerUrl)
$global:SolutionName = ($Config.target.SolutionName)
$global:UnmanagedPackageFile = ($Config.target.UnmanagedPackageFile)
$global:ManagedPackageFile = ($Config.target.ManagedPackageFile)
$global:Geography = ($Config.target.Geography)

Write-Host $global:ServerUrl
Write-Host $global:SolutionName
#Write-Host $global:UnmanagedPackageFile
#Write-Host $global:ManagedPackageFile
