$path = (Join-Path $PSScriptRoot "..\..\Solutions\Scripts\_GenerateTypes.ps1")
$process = "-noexit -Command $path -StartPath $PSScriptRoot -AutoExit 1 -ErrorAction Stop"
Write-Host $process
Start-Process powershell -ArgumentList $process -Wait