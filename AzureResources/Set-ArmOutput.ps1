param (
    [Parameter(Mandatory=$true)][string]$ARMOutput
 )
$json = $ARMOutput | ConvertFrom-Json
  $json.PSObject.Properties | ForEach-Object {
      $type = ($_.value.type).ToLower()
      $keyname = ($_.name)
      $value = $_.value.value
      if ($type -eq "securestring") {
          Write-Host "##vso[task.setvariable variable=$keyname;issecret=true]$value"
          Write-Host "Added Azure DevOps secret variable '$keyname' ('$type')"
      } elseif ($type -eq "string") {
          Write-Host "##vso[task.setvariable variable=$keyname]$value"
          Write-Host "Added Azure DevOps variable '$keyname' ('$type') with value '$value'"
      } else {
          Throw "Type '$type' is not supported for '$keyname'"
      }
  }
