Param(
	[string] [Parameter(Mandatory=$true)] $ReleaseWikiProjectName,
	[string] [Parameter(Mandatory=$true)] $ReleaseWikiName,
	[string] [Parameter(Mandatory=$true)] $ReleaseRootPath
)
[String]$project = "$env:SYSTEM_TEAMPROJECT"
[String]$baseurl= "$env:SYSTEM_TEAMFOUNDATIONCOLLECTIONURI"
[String]$DefinitionEnvironmentId="$env:RELEASE_DEFINITIONENVIRONMENTID"
$headers = @{ Authorization = "Bearer $env:SYSTEM_ACCESSTOKEN" }
[String]$releaseurl=$null
[String]$buildurl=$null
[int]$EnvBuildID=$env:BUILD_BUILDID

#Debug
#$ReleaseWikiProjectName="Te Ara Manaaki"
#$ReleaseWikiName="Te-Ara-Manaaki_wiki"
#$ReleaseRootPath="/CCMS/Staging-Releases"
#[String]$project = "Te Ara Manaaki"
#[String]$baseurl= "https://vsrm.dev.azure.com/sdo-online/"
#[String]$DefinitionEnvironmentId=36
#$headers = @{ Authorization = "Basic XXX" }

$releaseDate=Get-Date
$global:workItemsList=@()
[string]$releaseName=$env:RELEASE_RELEASENAME

#Markdown Template
$global:md=@"
#Release notes for $env:RELEASE_DEFINITIONNAME - $releaseName
**Environment**  : $env:RELEASE_ENVIRONMENTNAME
**Release Number**  : [$releaseName]($env:RELEASE_RELEASEWEBURL)
**Release Description**  : $env:RELEASE_RELEASEDDESCRIPTION
**Release Date** : $releaseDate
"@

#Function to retrieve Release based on filter parameter
function Get-Releases{
    param (
        $fiter=""
    )
    $url= [string]::Format("{0}/{1}/_apis/release/releases?api-version=5.0&`$Expand=environments,artifacts{2}",$releaseurl,$project,$fiter)    
    $response= Invoke-RestMethod -Uri $url  -ContentType "application/json; charset=utf-8" -headers $headers -Method GET
    return $response.value
}
#Function to retrieve Build based on filter parameter
function Get-Build{
    param (
        $fiter=""
    )
    $url= [string]::Format("{0}/{1}/_apis/build/builds?api-version=5.0{2}",$buildurl,$project,$fiter)    
    $response= Invoke-RestMethod -Uri $url  -ContentType "application/json; charset=utf-8" -headers $headers -Method GET
    return $response.value
}
#Function to recursively retrieve all the work items and their parent hierarchy
function Get-WorkItem {
    param (
        $idsList
    )
    if($null -eq $idsList -or $idsList.length -le 0){
        return
    }
    $ids=$idsList -join ','
    $url=[string]::Format("{0}/{1}/_apis/wit/workitems?api-version=5.0&ids={2}&`$expand=all",$buildurl,$project,$ids)
    $response= Invoke-RestMethod -Uri $url  -ContentType "application/json; charset=utf-8" -headers $headers -Method GET
    $parentIds=@()
    foreach($item in $response.value){
        $workItemproperties = @{}
        $workItemproperties.Add("id",$item.id)
        $workItemproperties.Add("title",$item.fields.'System.Title')
        $workItemproperties.Add("desc",$item.fields.'System.Description')
        $workItemproperties.Add("link",$item._links.html.href)
        if($null -ne $item.relations -and $item.relations.Length -gt 0){
            $parents=@()
            foreach($relation in $item.relations){
                if($relation.rel -eq "System.LinkTypes.Hierarchy-Reverse"){
                    $parentid=$relation.url.Substring($relation.url.LastIndexOf("/")+1,$relation.url.length-$relation.url.LastIndexOf("/")-1)   
                    #if(!$parentIds.Contains($parentid) -and !$parents.Contains($parentid)){
                        $parents+=($parentid)
                    #}                                  
                }
            }
            $workItemproperties.Add("parents",$parents)
            $parentIds+=($parents)
        }        
        $workItem = New-Object -TypeName psobject -Property $workItemproperties
        $global:workItemsList+=$workItem

    }
    if($parentIds.length -gt 0){
        Get-WorkItem -idsList $parentIds
    }    
}
#Function to create markdown for the workitems
function CreateWorkItem-Markdown {
    param (
        $Items,
        [int]$depth
    )
    foreach($item in $Items){ 
        $id=$item.id
        $title=$item.title
        $desc=$item.desc
        $link=$item.link
        $pad="".PadLeft($depth*2," ")
        $global:md+= 
@"

$pad* **[$title]($link)**$desc
"@

        $childItems= [Array]::FindAll($global:workItemsList, [Predicate[object]]{ 
            $null -ne $args[0].parents -and $args[0].parents.length -gt 0 -and $args[0].parents.Contains("$id")
        })
        if($childItems.length -gt 0){
            CreateWorkItem-Markdown -Items $childItems -depth ($depth+1)
        }        
    }
}

Write-Host "Getting Resource End Points" 


$response = Invoke-RestMethod -Uri ([string]::Format("{0}/_apis/resourceAreas/{1}?api-preview=5.0-preview.1", $baseurl, "efc2f575-36ef-48e9-b672-0c6fb4a48ac5"))
$releaseurl = $response.locationUrl

$response = Invoke-RestMethod -Uri ([string]::Format("{0}/_apis/resourceAreas/{1}?api-preview=5.0-preview.1", $baseurl, "5d6898bb-45ec-463f-95f9-54d49c71752e"))
$buildurl = $response.locationUrl


#Getting Last Successful Release for the Stage
Write-Host "Getting Last Successful Release for the Stage From Deployment"
$url=[string]::Format("{0}/{1}/_apis/release/deployments?api-version=5.0&definitionEnvironmentId={1}&deploymentStatus=succeeded&queryOrder=descending&`$top=1",$releaseurl,$project,$DefinitionEnvironmentId)
$response=$null
$response= Invoke-RestMethod -Uri $url  -ContentType "application/json; charset=utf-8" -headers $headers -Method GET

$filter=$null
$lastSuccessfulRelease=$null
$lastSuccessfulBuild=$null
$buildDefinationId=$null
if($null -ne $response -and $response.count -gt 0){
    $lastSuccessfulRelease=$response.value[0].release.id
    Write-Host "Last Successful Release ID:"$lastSuccessfulRelease
    $filter="`&releaseIdFilter="+$lastSuccessfulRelease   
    Write-Host "Getting Details For Last Successful Release" 
    $release = Get-Releases -fiter $filter
    $filter=$null
    if($null -ne $release){
        Write-Host "Details Retrieved For Last Successful Release" 
        $buildArtifact= $release.artifacts | Where-Object {
            $_.type -eq 'Build'
        }
        if($null -ne $buildArtifact){
            $lastSuccessfulBuild=$buildArtifact[0].definitionReference.version.id            
            $filter=$null
            $filter="&buildIds="+ $lastSuccessfulBuild
            Write-Host "Getting Build Detail for Build ID:" $lastSuccessfulBuild
            $lastbuild = Get-Build -fiter $filter
            if($null -ne $lastbuild){
                Write-Host "Details Retrieved For Build" 
                $filter="`&minTime="+$lastbuild.startTime+"&queryOrder=descending"
                $buildDefinationId=$lastbuild.definition.id
            }
        }        
    }
}
Write-Host "Getting all Builds after the last successfull release"
$buildList = Get-Build -fiter $filter

foreach($build in $buildList){   
    if(($build.id -eq $lastSuccessfulBuild -and $lastSuccessfulBuild -ne $EnvBuildID) -or $build.definition.id -ne $buildDefinationId -or $build.id -gt $EnvBuildID) {
        continue
    }
    $buildNumber= $build.buildNumber
    $buildLink=$build._links.web.href
    $global:md+= 
@"

## [Build $buildNumber]($buildLink)
### Associated work items
"@

    $linkedWorkItems= @()
    $global:workItemsList=@()
    $url=[string]::Format("{0}/{1}/_apis/build/builds/{2}/workitems?api-version=5.0",$buildurl,$project,$build.id)
    $response=$null
    $response= Invoke-RestMethod -Uri $url  -ContentType "application/json; charset=utf-8" -headers $headers -Method GET
 
    if($null -ne $response -and $response.count -gt 0){
        foreach($val in $response.value){
            $linkedWorkItems+=$val.id
        }
    }
    Get-WorkItem -idsList $linkedWorkItems 
    if($global:workItemsList.Length -le 0){
        continue
    }   
    $topItems= [Array]::FindAll($global:workItemsList, [Predicate[object]]{ 
        $null -eq $args[0].parents -or $args[0].parents.length -le 0 
    })  
    CreateWorkItem-Markdown -Items $topItems -depth 0
}
Write-Host $global:md

$url=[string]::Format("{0}/{1}/_apis/wiki/wikis/{2}/pages?path={3}/{4}&api-version=5.0",$buildurl,$ReleaseWikiProjectName,$ReleaseWikiName,$ReleaseRootPath,($env:RELEASE_ENVIRONMENTNAME+"-"+$releaseName))
$response=$null
[int]$statusCode=-1
try {
    $response = Invoke-RestMethod -Uri $url  -ContentType "application/json; charset=utf-8" -headers $headers -Method GET
}
catch {
    $statusCode = [int]$_.Exception.response.statuscode
}
if($statusCode -ne 404){
    Write-Host "Release notes wiki page already exists. Exiting"
    return
}
$body=@{content=$global:md} | ConvertTo-Json
$url=[string]::Format("{0}/{1}/_apis/wiki/wikis/{2}/pages?path={3}/{4}&api-version=5.0",$buildurl,$ReleaseWikiProjectName,$ReleaseWikiName,$ReleaseRootPath,$env:RELEASE_ENVIRONMENTNAME+"-"+$releaseName)
Invoke-RestMethod -Uri $url  -ContentType "application/json; charset=utf-8" -Body $body -headers $headers -Method Put