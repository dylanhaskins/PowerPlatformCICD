Param(
    [boolean] [Parameter(Mandatory = $false)] $DevMode = $false
)

$dm = [int]$DevMode
$path = (Join-Path $PSScriptRoot "..\..\Solutions\Scripts\SolutionExport.ps1")
$process = "-noexit -Command $path -DevMode $dm -StartPath $PSScriptRoot -ErrorAction Stop"
Write-Host $process
Start-Process powershell -ArgumentList $process