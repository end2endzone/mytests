Write-Output "Running override_build_version.ps1..."
Write-Output "Current branch: $env:APPVEYOR_REPO_BRANCH"
Write-Output "Current build version: $env:APPVEYOR_BUILD_VERSION"
If ("$env:APPVEYOR_REPO_BRANCH" -contains "prerelease") {
  Write-Output "Building from $env:APPVEYOR_REPO_BRANCH branch. Deploying each commits to GitHub..."

  $env:GITHUB_TAG_NAME="v$env:APPVEYOR_BUILD_VERSION-win32"
  $env:GITHUB_RELEASE_NAME="$env:APPVEYOR_PROJECT_NAME-v$env:APPVEYOR_BUILD_VERSION-win32"
}
Else
{
  Write-Output "Downgrading APPVEYOR_BUILD_VERSION environment variable...."

  $major, $minor, $patch, $build = $env:APPVEYOR_BUILD_VERSION.Split(".")
  #Strip out build number from $env:APPVEYOR_BUILD_VERSION
  $env:APPVEYOR_BUILD_VERSION = "$major.$minor.$patch"
  
  Write-Output "APPVEYOR_BUILD_VERSION is now set to '$env:APPVEYOR_BUILD_VERSION'"
  
  $env:GITHUB_TAG_NAME="nightly"
  $env:GITHUB_RELEASE_NAME="Nightly build (branch $env:APPVEYOR_REPO_BRANCH)"
}
Write-Output "APPVEYOR_BUILD_VERSION=$env:APPVEYOR_BUILD_VERSION"
Write-Output "GITHUB_TAG_NAME=$env:GITHUB_TAG_NAME"
Write-Output "GITHUB_RELEASE_NAME=$env:GITHUB_RELEASE_NAME"
