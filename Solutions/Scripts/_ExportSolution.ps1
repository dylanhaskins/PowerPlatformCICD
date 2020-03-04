
if (!$Credentials) {$Credentials = Get-Credential -Message "Credentials : $global:SolutionName @ $global:ServerUrl"}
if (!$conn) {$conn = Connect-CrmOnline -Credential $Credentials -ServerUrl $global:ServerUrl}

if($conn.IsReady){

######################## EXPORT SOLUTION
$message = "Exporting Unmanaged Solution for $global:SolutionName"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.6
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

Export-CrmSolution -SolutionName $global:SolutionName -SolutionZipFileName "$global:SolutionName.zip" -conn $conn

$message = "Exporting Managed Solution for $global:SolutionName"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.7
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

Export-CrmSolution -SolutionName $global:SolutionName -Managed -SolutionZipFileName $global:SolutionName"_managed.zip" -conn $conn


######################## EXTRACT SOLUTION
$ErrorActionPreference = "SilentlyContinue"
Remove-Item ..\..\package -Force -Recurse

$message = "Unpacking Solution $global:SolutionName"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.8
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

if ($PatchSolution) {
    &.\Tools\SolutionPackager.exe /action:extract /folder:..\..\packagePatch\ /zipfile:"$global:SolutionName.zip" /packagetype:Both /allowDelete:Yes /c
}else{
    Remove-Item ..\..\package\patch -Force -Recurse
    &.\Tools\SolutionPackager.exe /action:extract /folder:..\..\packageSolution\ /zipfile:"$global:SolutionName.zip" /packagetype:Both /allowDelete:Yes /c
}


}