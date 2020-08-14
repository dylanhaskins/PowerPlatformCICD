function Install-XrmModule{
    $moduleName = "Microsoft.Xrm.Data.Powershell"
    $moduleVersion = "2.8.8"
    $module = Get-Module -ListAvailable -Name $moduleName
    if (!($module.Version -ge $moduleVersion )) {
        Write-host "Module $moduleName version $moduleVersion or higher not found, installing now"
        Install-Module -Name $moduleName -MinimumVersion $moduleVersion -Force -Scope CurrentUser
    }
    else
    {
        Write-host "Module $moduleName Found"
    }
}

function Install-PowerAppsAdmin{
$moduleName = "Microsoft.PowerApps.Administration.PowerShell"
$moduleVersion = "2.0.66"
$module = Get-Module -ListAvailable -Name $moduleName
if (!($module.Version -ge $moduleVersion )) {
     Write-host "Module $moduleName version $moduleVersion or higher not found, installing now"
     Install-Module -Name $moduleName -MinimumVersion $moduleVersion -Force -AllowClobber
   }
   else
   {
     Write-host "Module $moduleName version $moduleVersion or higher Found"
   }
}

function Install-PowerAppsPowerShell{
$moduleName = "Microsoft.PowerApps.PowerShell"
$moduleVersion = "1.0.13"
$module = Get-Module -ListAvailable -Name $moduleName
if (!($module.Version -ge $moduleVersion )) {
     Write-host "Module $moduleName version $moduleVersion or higher not found, installing now"
     Install-Module -Name $moduleName -MinimumVersion $moduleVersion -Force -AllowClobber
   }
else
{
Write-host "Module $moduleName Found"
}
}