[string]$drop = "$env:SYSTEM_DEFAULTWORKINGDIRECTORY/$env:RELEASE_PRIMARYARTIFACTSOURCEALIAS/drop"

$path = $drop + "/Solutions/bin/Release/ReferenceData/data.xml"
Write-Host "data.xml path: $path"

$xml = [xml](Get-Content $path)
$xml.Load($path)

$configSettings = $xml.entities.entity | where {$_.name -eq "dia_configuration"} 

$pipelineVariables = @{}
$pipelineVariables.add("NZClientSecret","#{nzpost-clientsecret}#")
$pipelineVariables.add("NZClientID", "#{nzpost-clientid}#")

Write-Host "Replacing values"
foreach ($record in $configSettings.records.ChildNodes) {
    foreach ($field in $record.field) {       
        if($pipelineVariables.ContainsKey($field.value)) {
			Write-Host "Found: " + $field.value + " - " + $pipelineVariables[$field.value]
            $value = $record.field | where {$_.name -eq "dia_value"}
			if($value) {
				Write-Host "Updating Value : " + $value
				$value.SetAttribute("value", $pipelineVariables[$field.value]);
			}
            break;
        }
    }
}
Write-Host "Save new data.xml"
$xml.Save($path)

Write-Host "Compressing data file"
$compressPath  = $drop + "/Solutions/bin/Release/ReferenceData/*"
$destinationPath  = $drop + "/PackageDeployer/bin/Release/PkgFolder/ImportFiles/CCMSReferenceDataCore"
Compress-Archive -Path $compressPath -CompressionLevel Fastest -DestinationPath $destinationPath -Force