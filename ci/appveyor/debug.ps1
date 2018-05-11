################################################################
# Debug
################################################################
$location = Get-Location
Write-Output "Get-Location: '$location'"
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
$ScriptName = $MyInvocation.MyCommand.Name
Write-Output "ScriptName: '$ScriptName'"

Write-Output "$$script:MyInvocation.MyCommand.Path: '$script:MyInvocation.MyCommand.Path'"
Write-Output "$$MyInvocation.MyCommand.Definition: '$MyInvocation.MyCommand.Definition'"
Write-Output "$$MyInvocation.MyCommand.Name: '$MyInvocation.MyCommand.Name'"
Write-Output "$$MyInvocation.MyCommand: {"
Write-Output $MyInvocation.MyCommand
Write-Output "}"

Write-Output ""
