$root = $PSScriptRoot
$files = Get-ChildItem -Path $root -Recurse -include *.csproj, *.cs, *.js, *.ts, *.json, *.config, *.ps1, *.xml, *.shproj -exclude NameSpaceRename.ps1 

$repValues = 
@{
'CCMS.Core.'					= 'CCMS.Core.';
'ccmsdev02.'					= 'ccmsdev02.';
'CCMS.Core.SolutionName'		= 'CCMS.Core.SolutionName';
'CCMSCore'						= 'CCMSCore';
'CCMSCorePlugins'				= 'CCMSCorePlugins';
'CCMSCoreWorkflows'				= 'CCMSCoreWorkflows';
'CCMSReferenceDataCore'			= 'CCMSReferenceDataCore';
}

$stmtsToReplace = @()
foreach ($key in $repValues.Keys) { $stmtsToReplace += $null }
$repValues.Keys.CopyTo($stmtsToReplace, 0)

foreach ($file in $files)
{
$path = [IO.Path]::Combine($file.DirectoryName, $file.Name)

$sel = Select-String -Pattern $stmtsToReplace -Path $path -list

if ($sel -ne $null)
{
    write "Modifying file $path" 

    (Get-Content -Encoding Ascii $path) | 
    ForEach-Object {
        $containsStmt = $false
        foreach ($key in $repValues.Keys) 
        {
            if ($_.Contains($key))
            { 
                $_.Replace($key, $repValues[$key])
                $containsStmt = $true
                break
            }
        }
        if (!$containsStmt) { $_ } 
    } |
    Set-Content -Encoding Ascii $path
}
}