Param(
    [string] [Parameter(Mandatory = $false)] $Branch = "master",
    [string] [Parameter(Mandatory = $false)] $FeatureBranch = "master"
)

#$sourceFile = Invoke-WebRequest "https://raw.githubusercontent.com/dylanhaskins/PowerPlatformCICD/$branch/AddSolution.ps1" -UseBasicParsing:$true
#Set-Content .\AddSolution.ps1 -Value $sourceFile.Content

#$sourceFile = Invoke-WebRequest "https://raw.githubusercontent.com/dylanhaskins/PowerPlatformCICD/$branch/AddSolution_Full.ps1" -UseBasicParsing:$true
#Set-Content .\AddSolution_Full.ps1 -Value $sourceFile.Content

Start-Sleep -Seconds 2

& .\AddSolution_Full.ps1 -ErrorAction Stop #-Branch $FeatureBranch

