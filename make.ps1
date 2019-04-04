param (
    [string] $version = '0.0.0'
)

$ErrorActionPreference = 'Stop'

$scriptPath = Split-Path $MyInvocation.MyCommand.Path

$startDate = Get-Date

$elapsed = (Get-Date) - $startDate
Write-Output "Build duration: $elapsed"