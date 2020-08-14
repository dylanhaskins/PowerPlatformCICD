function Restart-PowerShell
{
    Start-Sleep -Seconds 5
    refreshenv
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
    Clear-Host
}

if (!$env:ChocolateyInstall) {
    Write-Warning "The ChocolateyInstall environment variable was not found. `n Chocolatey is not detected as installed. Installing..."
    $message = "Installing Chocolatey ...."
    Write-Host $message
    
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

choco upgrade chocolatey -y
 
$message = "Installing Git ...."
Write-Host $message

choco upgrade git.install -y

$message = "Installing NodeJS ...."
Write-Host $message

choco upgrade nodejs-lts -y

$message = "Installing Azure CLI ...."
Write-Host $message
choco upgrade azure-cli -y 

$message = "Installing dotnet CLI ...."
Write-Host $message

choco upgrade dotnetcore -y

## Restart PowerShell Environment to Enable Azure CLI
Restart-PowerShell
