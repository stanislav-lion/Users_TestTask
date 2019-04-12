$ErrorActionPreference = 'Stop'

$scriptPath = Split-Path $MyInvocation.MyCommand.Path

$packagesDirectoryPath = Join-Path $scriptPath '..\Packages'
$xUnitDirectoryPath = Get-ChildItem -Directory -Path $packagesDirectoryPath -include 'xunit.runner.console*' -Recurse -Force
$xUnitRunnerConsoleDirectoryPath = Join-Path $xUnitDirectoryPath 'tools\net452'

$testRunnerDirectoryPath = Join-Path $scriptPath "..\TestRunner"
if (-not (Test-Path $testRunnerDirectoryPath -PathType Container))
{
    New-Item $testRunnerDirectoryPath -ItemType Directory
}

Copy-Item "$xUnitRunnerConsoleDirectoryPath\*" -Destination $testRunnerDirectoryPath -Recurse -Force