
if (!$Credentials) {$Credentials = Get-Credential -Message "Credentials : $global:SolutionName @ $global:ServerUrl"}
if (!$conn) {$conn = Connect-CrmOnline -Credential $Credentials -ServerUrl $global:ServerUrl}

if($conn.IsReady){

Remove-Item (Join-Path $PSScriptRoot "..\package*patch*") -Force -Recurse

    ######################## EXPORT SOLUTION

    ##Export Patches if they Exist
    foreach ($PatchSolution in $PatchQuery.CrmRecords)
    {
        $SolutionId = $PatchSolution.solutionid
        $SolutionName = $PatchSolution.uniquename
        $SolutionVersion = $PatchSolution.version

        $message = "Exporting Unmanaged Solution for $SolutionName"
        Write-Host $message
        $ProgressBar = New-BTProgressBar -Status $message -Value 0.6
        New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

        Export-CrmSolution -SolutionName $SolutionName -SolutionZipFileName "$SolutionName.zip" -conn $conn

        $message = "Exporting Managed Solution for $SolutionName"
        Write-Host $message
        $ProgressBar = New-BTProgressBar -Status $message -Value 0.7
        New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

        Export-CrmSolution -SolutionName $SolutionName -Managed -SolutionZipFileName $SolutionName"_managed.zip" -conn $conn

        $Path = (Join-Path $PSScriptRoot "..\..\PackageDeployer")
        $ImportConfig = Get-ChildItem -Path $Path -Include "ImportConfig.xml" -Recurse
                                
        [xml] $xdoc = (Get-Content -Path "$($ImportConfig.DirectoryName)\ImportConfig.xml")

        $node = $xdoc.SelectSingleNode("//configsolutionfile[contains(@solutionpackagefilename,'$($SolutionName)_managed.zip')]")               
        If (!$node) {
            $patch = $xdoc.configdatastorage.solutions.FirstChild.Clone()
            $patch.solutionpackagefilename = "$($SolutionName)_managed.zip"
            $patch.overwriteunmanagedcustomizations = "true"
            $xdoc.configdatastorage.solutions.AppendChild($patch)
            $xdoc.Save("$($ImportConfig.DirectoryName)\ImportConfig.xml")
        }
        ######################## EXTRACT SOLUTION
        $ErrorActionPreference = "SilentlyContinue"       

        $message = "Unpacking Solution $SolutionName"
        Write-Host $message
        $ProgressBar = New-BTProgressBar -Status $message -Value 0.8
        New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId
        &.\Tools\SolutionPackager.exe /action:extract /folder:(Join-Path $PSScriptRoot "..\package$SolutionName\") /zipfile:"$SolutionName.zip" /packagetype:Both /allowDelete:Yes /c
     }
    
    ## No Patches
    If (!$PatchQuery.CrmRecords)
    {
        $message = "Exporting Unmanaged Solution for $SolutionName"
        Write-Host $message
        $ProgressBar = New-BTProgressBar -Status $message -Value 0.6
        New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

        Export-CrmSolution -SolutionName $SolutionName -SolutionZipFileName "$SolutionName.zip" -conn $conn

        $message = "Exporting Managed Solution for $SolutionName"
        Write-Host $message
        $ProgressBar = New-BTProgressBar -Status $message -Value 0.7
        New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId

        Export-CrmSolution -SolutionName $SolutionName -Managed -SolutionZipFileName $SolutionName"_managed.zip" -conn $conn

        $Path = (Join-Path $PSScriptRoot "..\..\PackageDeployer")
        $ImportConfig = Get-ChildItem -Path $Path -Include "ImportConfig.xml" -Recurse
                                
        [xml] $xdoc = (Get-Content -Path "$($ImportConfig.DirectoryName)\ImportConfig.xml")

        $nodes = $xdoc.configdatastorage.solutions.SelectNodes("//configsolutionfile")         
        $nodes[0].solutionpackagefilename = "$($SolutionName)_managed.zip"
        $nodes[0].overwriteunmanagedcustomizations = "true"
        Write-Host Nodes $nodes.Count
        for ($i=1; $i -le ($nodes.Count-1); $i++)
        {
            $nodes[$i].ParentNode.RemoveChild($nodes[$i])
        }
            
        $xdoc.Save("$($ImportConfig.DirectoryName)\ImportConfig.xml")
        
        ######################## EXTRACT SOLUTION
        $ErrorActionPreference = "SilentlyContinue"


        $message = "Unpacking Solution $SolutionName"
        Write-Host $message
        $ProgressBar = New-BTProgressBar -Status $message -Value 0.8
        New-BurntToastNotification -Text $Text -ProgressBar $ProgressBar -Silent -UniqueIdentifier $UniqueId
        Remove-Item (Join-Path $PSScriptRoot "..\package$SolutionName\") -Recurse -Force
        &.\Tools\SolutionPackager.exe /action:extract /folder:(Join-Path $PSScriptRoot "..\package$SolutionName\") /zipfile:"$SolutionName.zip" /packagetype:Both /allowDelete:No /c /useUnmanagedFileForMissingManaged
     }

}