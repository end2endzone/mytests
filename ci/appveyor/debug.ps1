################################################################
# Debug
################################################################
$location = Get-Location
Write-Output "Get-Location: '$location'"
Write-Output ""

$relativePath = Get-Item "..\..\version" | Resolve-Path -Relative
Write-Output "relativePath: '$relativePath'"
Write-Output ""

$ScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Write-Output "ScriptDir: '$ScriptDir'"
Write-Output ""

$FilePath = Split-Path $script:MyInvocation.MyCommand.Path
Write-Output "FilePath: '$FilePath'"
Write-Output ""

Write-Output "`$script:MyInvocation.MyCommand.Path: "
$script:MyInvocation.MyCommand.Path
Write-Output ""

Write-Output "`$MyInvocation.MyCommand.Definition:"
$MyInvocation.MyCommand.Definition
Write-Output ""

Write-Output "`$MyInvocation.MyCommand.Name:"
$MyInvocation.MyCommand.Name
Write-Output ""

Write-Output "`$MyInvocation.MyCommand: {"
$MyInvocation.MyCommand
Write-Output "}"
Write-Output ""
