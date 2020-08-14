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

function Install-XrmToolingPowerShell{
    $moduleName = "Microsoft.Xrm.Tooling.CrmConnector.PowerShell"
    $moduleVersion = "3.3.0.899"
    $module = Get-Module -ListAvailable -Name $moduleName
    if (!($module.Version -ge $moduleVersion )) {
         Write-host "Module $moduleName version $moduleVersion or higher not found, installing now"
         Install-Module -Name $moduleName -MinimumVersion $moduleVersion -Force -AllowClobber
       }
    else
    {
    Write-host "Module $moduleName Found"
    Import-Module -Name $moduleName -MinimumVersion $moduleVersion -Force
    }
}

function Format-Json {
  <#
  .SYNOPSIS
      Prettifies JSON output.
  .DESCRIPTION
      Reformats a JSON string so the output looks better than what ConvertTo-Json outputs.
  .PARAMETER Json
      Required: [string] The JSON text to prettify.
  .PARAMETER Minify
      Optional: Returns the json string compressed.
  .PARAMETER Indentation
      Optional: The number of spaces (1..1024) to use for indentation. Defaults to 4.
  .PARAMETER AsArray
      Optional: If set, the output will be in the form of a string array, otherwise a single string is output.
  .EXAMPLE
      $json | ConvertTo-Json  | Format-Json -Indentation 2
  #>
  [CmdletBinding(DefaultParameterSetName = 'Prettify')]
  Param(
      [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
      [string]$Json,

      [Parameter(ParameterSetName = 'Minify')]
      [switch]$Minify,

      [Parameter(ParameterSetName = 'Prettify')]
      [ValidateRange(1, 1024)]
      [int]$Indentation = 4,

      [Parameter(ParameterSetName = 'Prettify')]
      [switch]$AsArray
  )

  if ($PSCmdlet.ParameterSetName -eq 'Minify') {
      return ($Json | ConvertFrom-Json) | ConvertTo-Json -Depth 100 -Compress
  }

  # If the input JSON text has been created with ConvertTo-Json -Compress
  # then we first need to reconvert it without compression
  if ($Json -notmatch '\r?\n') {
      $Json = ($Json | ConvertFrom-Json) | ConvertTo-Json -Depth 100
  }

  $indent = 0
  $regexUnlessQuoted = '(?=([^"]*"[^"]*")*[^"]*$)'

  $result = $Json -split '\r?\n' |
      ForEach-Object {
          # If the line contains a ] or } character, 
          # we need to decrement the indentation level unless it is inside quotes.
          if ($_ -match "[}\]]$regexUnlessQuoted") {
              $indent = [Math]::Max($indent - $Indentation, 0)
          }

          # Replace all colon-space combinations by ": " unless it is inside quotes.
          $line = (' ' * $indent) + ($_.TrimStart() -replace ":\s+$regexUnlessQuoted", ': ')

          # If the line contains a [ or { character, 
          # we need to increment the indentation level unless it is inside quotes.
          if ($_ -match "[\{\[]$regexUnlessQuoted") {
              $indent += $Indentation
          }

          $line
      }

  if ($AsArray) { return $result }
  return $result -Join [Environment]::NewLine
}