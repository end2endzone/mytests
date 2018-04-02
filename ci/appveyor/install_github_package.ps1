Param(
  [Parameter(Mandatory=$True)]
  [string]$name,
  [Parameter(Mandatory=$True)]
  [string]$version,
  [Parameter(Mandatory=$True)]
  [string]$installpath,
  [Parameter(Mandatory=$True)]
  [string]$url
)

############################################
# Create installation directory
############################################
$command_output = New-Item -ItemType Directory -Force -Path $installpath

############################################
# Delete previous installations
############################################
Write-Host "Deleting previous $name installations..."
function DeleteIfExists($path)
{
  if ( Test-Path $path -PathType Container )
  {
    $command_output = Remove-Item –Path "$path" –recurse
  }
}
DeleteIfExists -Path "$installpath\$name"
DeleteIfExists -Path "$installpath\$name-version"
Write-Host "Done."
Write-Host ""

############################################
# Download
############################################
$tempfile = "$env:temp\$name.tmp.zip"
Write-Host "Downloading $name zip package:"
Write-Host "  from $url"
Write-Host "  to file '$tempfile'"
(New-Object System.Net.WebClient).DownloadFile($url, $tempfile)
Write-Host "Download completed sucessfully."
Write-Host ""

############################################
# Search
############################################
function FindZipRootFolderName($file)
{
  $shell = new-object -com shell.application
  $zip = $shell.NameSpace($file)
  foreach($item in $zip.items())
  {
    return $item.Name
  }
  return ""
}
$zipRootFolderName = FindZipRootFolderName -File $tempfile
Write-Host "Found folder '$zipRootFolderName' in zip archive..."

############################################
# Unzip
############################################
Write-Host "Extracting zip content:"
Write-Host "  file '$tempfile'"
Write-Host "  to directory '$installpath'"
function Expand-ZIPFile($file, $destination)
{
  $shell = new-object -com shell.application
  $zip = $shell.NameSpace($file)
  foreach($item in $zip.items())
  {
    $shell.Namespace($destination).copyhere($item)
  }
}
Expand-ZIPFile -File $tempfile -Destination $installpath
Write-Host "Extraction completed sucessfully."
Write-Host ""

############################################
# Delete temp.zip file
############################################
Write-Host "Deleting temporary zip file."
$command_output = Remove-Item –path $tempfile –recurse
Write-Host "Done."
Write-Host ""

############################################
# Rename actual file
############################################
Write-Host "Renaming folder '$zipRootFolderName' to '$name'."
$command_output = Rename-Item -Path "$installpath\$zipRootFolderName" -NewName $name
Write-Host "Done."
Write-Host ""

############################################
# Define package HOME variable.
############################################
$envname  = $name + "_HOME"
$envname = $envname.ToUpper()
$envvalue = "$installpath\$name"
Write-Host "Setting environment variable '$envname' to value '$envvalue'."
[Environment]::SetEnvironmentVariable($envname, $envvalue, "User")
Write-Host "Done."
Write-Host ""

exit 0
