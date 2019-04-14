param (
    [string] $version = '0.0.0'
)

$ErrorActionPreference = 'Stop'

$scriptPath = Split-Path $MyInvocation.MyCommand.Path

$startDate = Get-Date

& "$scriptPath\cleanup.ps1"

& "$scriptPath\scripts\build.src.ps1"
& "$scriptPath\scripts\clean.analysis.results.ps1"

$elapsed = (Get-Date) - $startDate
Write-Output "Build duration: $elapsed"