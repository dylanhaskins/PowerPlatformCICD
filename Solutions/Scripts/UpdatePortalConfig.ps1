# Variables
$XPath = "/entities/entity/records/record/field"
$errorAction = "Stop"
$nameField = "adx_name"
$valueField = "adx_value"

# $json = "C:\Users\susanz\Desktop\Delete\AsureQuality\values.json"
# $jsonArray = Get-Content $json | ConvertFrom-Json

# Fill me in
# pass json array from variables and then arguments
$jsonArray = "$Env:portalConfigJson" | ConvertFrom-Json
$path = "$env:SYSTEM_DEFAULTWORKINGDIRECTORY/_CCMS-D365-Portal/drop/portalconfig/data.xml"

# --- Start of script --- #
Try {
	$xml = New-Object -Typename XML
    $xml.load($path)

    # Loop through the json array
    For ($i = 0; $i -lt $jsonArray.Count; $i++) { 
            
        $lookupName = $jsonArray[$i].$nameField
        $newValue = $jsonArray[$i].$valueField

        # Check if the attribute exists
        if ($null -ne ($name = $xml.SelectNodes($XPath) | Where-Object { ($_.name -eq $nameField -and $_.value -eq $lookupName) } -ErrorAction SilentlyContinue)) {
            
            # Get name attribute
            $name = $xml.SelectNodes($XPath) | Where-Object { ($_.name -eq $nameField -and $_.value -eq $lookupName) }
            # Retrieve other attributes within element
            $nameParentId = $name.ParentNode.id
            $parent = $xml.SelectNodes("/entities/entity/records/record[@id='$nameParentId']")
            # Replace value attribute
            $value = $parent.field | Where-Object { ($_.name -eq $valueField) } -ErrorAction $errorAction
            $value.value = $newValue

            Write-Host "$lookupName :> $newValue" -ForegroundColor Green
        }
        else {
            Write-Host "The attribute $lookupName does not exist" -ForegroundColor DarkRed
        }
    }

    # Save XML

    $xml.Save($path)
	
}
Catch {
	Write-Host $_.Exception
    $ErrorMessage = $_.Exception.Message
    Write-Host $ErrorMessage -ForegroundColor Red
}
    
# --- End of script --- #