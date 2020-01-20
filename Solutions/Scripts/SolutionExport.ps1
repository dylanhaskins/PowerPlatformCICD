######################## SETUP 
& ((Split-Path $MyInvocation.InvocationName) + "\_SetupTools.ps1")
& ((Split-Path $MyInvocation.InvocationName) + "\_Config.ps1")

######################## GET CONNECTION
$Credentials = Get-Credential
$conn = Connect-CrmOnline -Credential $Credentials -ServerUrl $global:ServerUrl
Write-Output($conn)

######################## Generate Config Migration data 
& ((Split-Path $MyInvocation.InvocationName) + "\_ConfigMigration.ps1")

######################## Generate Types
Write-Host("Cleaning up Context Files...")
& ((Split-Path $MyInvocation.InvocationName) + "\_GenerateTypes.ps1")

######################## UPDATE VERSION
$currentVersion = (Get-CrmRecords -conn $conn -EntityLogicalName solution -FilterAttribute uniquename -FilterOperator "like" -FilterValue $global:SolutionName -Fields uniquename,publisherid,version).CrmRecords | select version
Write-Host("Current Version - $currentVersion")
$theVersion = [version]$currentVersion.version
$newVersion = "{0}.{1}{2}.{3}.{4}" -f $theVersion.Major, (Get-Date -UFormat %y),(Get-Date -UFormat %j).PadLeft(3,'0'), $theVersion.Build , (Get-Date -UFormat %H%M)
Set-CrmSolutionVersionNumber -SolutionName $global:SolutionName -VersionNumber $newVersion -conn $conn
Write-Host("New Version - $newVersion")

######################## EXPORT SOLUTION
Write-Host "Exporting Unmanaged Solution"
Export-CrmSolution -SolutionName $global:SolutionName -SolutionZipFileName $global:UnmanagedPackageFile

Write-Host "Exporting Managed Solution"
Export-CrmSolution -SolutionName $global:SolutionName -Managed -SolutionZipFileName $global:ManagedPackageFile

######################## EXTRACT SOLUTION
Remove-Item ..\..\package -Force -Recurse
&.\Tools\SolutionPackager.exe /action:extract /folder:..\..\package /zipfile:$global:UnmanagedPackageFile /packagetype:Both 

