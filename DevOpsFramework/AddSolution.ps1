Param(
    [string] [Parameter(Mandatory = $false)] $Branch = "master",
    [string] [Parameter(Mandatory = $false)] $FeatureBranch = "master"
)

Start-Sleep -Seconds 2

& .\AddSolution_Full.ps1 -ErrorAction Stop 
