Param(
    [string] [Parameter(Mandatory=$true)] $configFilePath,
    [hashtable] [Parameter(Mandatory=$true)] $appsettings
)

if(!(Test-Path $configFilePath)){
    Write-Host "##vso[task.logissue type=error;]$configFilePath does not exist."
    return
}

Write-Host "Updating $configFilePath file..."
[xml]$xmlDoc = Get-Content $configFilePath 

foreach ($key in $appsettings.Keys) {
    $value = $appsettings[$key]
    if(($addKey = $xmlDoc.SelectSingleNode("//appSettings/add[@key = '$key']"))){
        $addKey.SetAttribute('value',$appsettings[$key])
    }
}

$xmlDoc.Save($configFilePath)
Write-Host "$configFilePath updated !!!"