Param(
	[string] [Parameter(Mandatory= $true)] $StartPath,
	[boolean] [Parameter(Mandatory= $false)] $AutoExit = $false
)
######################## SETUP 
. (Join-Path $PSScriptRoot "_Config.ps1") -StartPath $StartPath

if (!$Credentials)
{
	$Credentials = Get-Credential -Message "Credentials : $global:SolutionName @ $global:ServerUrl"
}
if (!$username)
{
	$username =  $Credentials.GetNetworkCredential().UserName
	$password =  $Credentials.GetNetworkCredential().Password
}

if (!$conn) {$conn = Connect-CrmOnline -Credential $Credentials -ServerUrl $global:ServerUrl}

if($conn.IsReady){

$message = "Generating Context and Types from $global:ServerUrl"
Write-Host $message
$ProgressBar = New-BTProgressBar -Status $message -Value 0.4
New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

Write-Host("Cleaning up Context Files...")
#clean up
Move-Item (Join-Path $PSScriptRoot "..\Entities\Context\Actions.cs") (Join-Path $PSScriptRoot "\Actions.cs") -Force -ErrorAction Ignore
Remove-Item (Join-Path $PSScriptRoot "..\Entities\Context") -Force -Recurse -ErrorAction Ignore
Remove-Item (Join-Path $PSScriptRoot "..\WebResources\typings\XRM") -Force -Recurse -ErrorAction Ignore

New-Item -ItemType Directory -Path (Join-Path $PSScriptRoot "..\Entities\Context") -ErrorAction Ignore
New-Item -ItemType Directory -Path (Join-Path $PSScriptRoot  "..\WebResources\typings\XRM") -ErrorAction Ignore

Move-Item (Join-Path $PSScriptRoot "\Actions.cs") (Join-Path $PSScriptRoot "..\Entities\Context\Actions.cs") -Force -ErrorAction Ignore


	#generate types
$CurrentLocation = Get-Location
$xc = (Get-ChildItem -Path $env:USERPROFILE\.nuget\packages -Filter XrmContext.exe -Recurse | Sort-Object CreationTime -Descending | Select-Object -First 1).DirectoryName
$xd = (Get-ChildItem -Path $env:USERPROFILE\.nuget\packages -Filter XrmDefinitelyTyped.exe -Recurse | Sort-Object CreationTime -Descending | Select-Object -First 1).DirectoryName
$exclude = @('*.ps1','*.config')
if (Test-Path (Join-Path $StartPath "..\XrmContext"))
{
Set-Location -Path (Join-Path $StartPath "..\XrmContext")
Copy-Item -Path $xc\*.* -Destination . -Exclude $exclude -Force -ErrorAction SilentlyContinue
. .\XrmContext.exe /url:$global:ServerUrl/XRMServices/2011/Organization.svc /username:$username /password:$password /useconfig /out:"../Entities/Context"
}
if (Test-Path (Join-Path $StartPath "..\XrmDefinitelyTyped"))
{
Set-Location -Path (Join-Path $StartPath "..\XrmDefinitelyTyped")
Copy-Item -Path $xd\*.* -Destination . -Exclude $exclude -Force -ErrorAction SilentlyContinue
. .\XrmDefinitelyTyped.exe /url:$global:ServerUrl/XRMServices/2011/Organization.svc /username:$username /password:$password /useconfig /out:"../Webresources/typings/XRM" /jsLib:"../Webresources/src/library"
}
Set-Location -Path $CurrentLocation
##Add Files to Project
[xml]$xdoc = (Get-Content (Join-Path $StartPath "..\$global:ProjectName.csproj"))

[System.Xml.XmlNamespaceManager] $nsmgr = $xdoc.NameTable
$nsmgr.AddNamespace('a','http://schemas.microsoft.com/developer/msbuild/2003')

$nodes = $xdoc.SelectNodes("//a:Compile[contains(@Include,'Entities\Context')]",$nsmgr)
for ($i=0; $i -le ($nodes.Count-1); $i++)
        {
            $nodes[$i].ParentNode.RemoveChild($nodes[$i])
        }

$newnodes = $xdoc.SelectNodes("//a:Compile",$nsmgr)
$addNode = $newnodes[0].Clone()

Get-ChildItem (Join-Path $StartPath "..\Entities\Context") -Name | ForEach-Object {
	$newnodes = $xdoc.SelectNodes("//a:Compile",$nsmgr)
    $addNode = $newnodes[0].Clone()
	$addNode.Include = "Entities\Context\$_"; $newnodes[0].ParentNode.AppendChild($addNode)
}

$xdoc.Save((Join-Path $StartPath "..\$global:ProjectName.csproj"))
}
if ($AutoExit) {Stop-Process -Id $PID}
