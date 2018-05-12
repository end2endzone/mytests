Param(
  [Parameter(Mandatory=$True)]
  [string]$name
)
$ScriptName = $MyInvocation.MyCommand.Name
Write-Output "Hello from $ScriptName. My name is $name..."
