function toSemVerObject($versionStr)
{
  #RegEx string taken from https://github.com/maxhauser/semver/
  $versionStr -match "^(?<major>\d+)(\.(?<minor>\d+))?(\.(?<patch>\d+))?(\-(?<pre>[0-9A-Za-z\-\.]+))?(\+(?<build>[0-9A-Za-z\-\.]+))?$" | Out-Null
  $major = [int]$matches['major']
  $minor = [int]$matches['minor']
  $patch = [int]$matches['patch']
  $pre   =      $matches['pre']
  $meta  =      $matches['build']
 
  return New-Object PSObject -Property @{
    VersionStr = $versionStr
    Major = $major
    Minor = $minor
    Patch = $patch
    Pre = $pre
    Meta = $meta
  }
}
 
 
################################################################
# TESTS
################################################################
# $versionStr = @(
#   "1.0.0-alpha",
#   "1.0.0-alpha.1",
#   "1.0.0-0.3.7",
#   "1.0.0-x.7.z.92",
#   "1.0.0-alpha+001",
#   "1.0.0+20130313144700",
#   "1.0.0-beta+exp.sha.5114f85",
#   "1.0.0-alpha.beta",
#   "1.0.0-beta",
#   "1.0.0-beta.2",
#   "1.0.0-beta.11",
#   "1.0.0-rc.1",
#   "1.0.0"
# )
# foreach($v in $versionStr)
# {
#   $semver = toSemVerObject($v)
#   Write-Output "{"
#   Write-Output $semver
#   Write-Output "}"
# }
# 

# based off of http://mnaoumov.wordpress.com/2013/08/21/powershell-resolve-path-safe/
function Resolve-AbsolutePath{
    [cmdletbinding()]
    param
    (
        [Parameter(
            Mandatory=$true,
            Position=0,
            ValueFromPipeline=$true)]
        [string] $path
    )
     
    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($path)
}

################################################################
# Debug
################################################################
$location = Get-Location
Write-Output "location: '$location'"
$relativePath = Get-Item "..\..\version" | Resolve-Path -Relative
Write-Output "relativePath: '$relativePath'"
$ScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Write-Output "ScriptDir: '$ScriptDir'"
Function Get-AbsolutePath {
    param([string]$Path)
    
    [System.IO.Path]::GetFullPath([System.IO.Path]::Combine((Get-Location).ProviderPath, $Path));
}
$MyAbsolutePath = Get-AbsolutePath -Path "."
Write-Output "MyAbsolutePath: '$MyAbsolutePath'"
$test1 = get-location -PSProvider filesystem | select -exp path;
Write-Output "test1: '$test1'"
$test2 = Split-Path $script:MyInvocation.MyCommand.Path
Write-Output "test2: '$test2'"
Write-Output ""


################################################################
# Read content of file product version file
################################################################

$ScriptName = $MyInvocation.MyCommand.Name
$filepath = Resolve-AbsolutePath -Path "$ScriptName\..\..\..\version"
Write-Output "Parsing version from file '$filepath'"

# Read project version and save as environment variable for future use.
$env:PRODUCT_VERSION = Get-Content -Path $filepath
Write-Output "Found product version '$env:PRODUCT_VERSION'"

$versionObj = toSemVerObject($env:PRODUCT_VERSION)
$env:SEMVER_MAJOR = $versionObj.Major
$env:SEMVER_MINOR = $versionObj.Minor
$env:SEMVER_PATCH = $versionObj.Patch
$env:SEMVER_PRE = $versionObj.Pre
$env:SEMVER_META = $versionObj.Meta

# Write-Output "$env:PRODUCT_VERSION"
# Write-Output "$env:SEMVER_MAJOR"
# Write-Output "$env:SEMVER_MINOR"
# Write-Output "$env:SEMVER_PATCH"
# Write-Output "$env:SEMVER_PRE"
# Write-Output "$env:SEMVER_META"
