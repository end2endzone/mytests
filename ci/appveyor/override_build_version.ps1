Write-Output "Running override_build_version.ps1..."
Write-Output "Current branch: $env:APPVEYOR_REPO_BRANCH"
Write-Output "Current build version: $env:APPVEYOR_BUILD_VERSION"
If ("$env:APPVEYOR_REPO_BRANCH" -eq "master") {
  $major, $minor, $patch, $build = $env:APPVEYOR_BUILD_VERSION.Split(".")
  
  #Strip out build number from $env:APPVEYOR_BUILD_VERSION
  $env:APPVEYOR_BUILD_VERSION = "$major.$minor.$patch"
  
  $env:GITHUB_TAG_NAME="v$env:APPVEYOR_BUILD_VERSION-win32"
  $env:GITHUB_RELEASE_NAME="$env:APPVEYOR_PROJECT_NAME-v$env:APPVEYOR_BUILD_VERSION-win32"
}
Else
{
  $env:GITHUB_TAG_NAME="v$env:APPVEYOR_BUILD_VERSION.$env:APPVEYOR_BUILD_NUMBER-win32"
  $env:GITHUB_RELEASE_NAME="$env:APPVEYOR_PROJECT_NAME-v$env:APPVEYOR_BUILD_VERSION.$env:APPVEYOR_BUILD_NUMBER-win32"
  $env:PRODUCT_VERSION="$env:APPVEYOR_BUILD_VERSION.$env:APPVEYOR_BUILD_NUMBER"
}
Write-Output "GITHUB_TAG_NAME=$env:GITHUB_TAG_NAME"
Write-Output "GITHUB_RELEASE_NAME=$env:GITHUB_RELEASE_NAME"
Write-Output "APPVEYOR_BUILD_VERSION=$env:APPVEYOR_BUILD_VERSION"
