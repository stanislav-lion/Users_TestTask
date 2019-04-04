$ErrorActionPreference = 'Stop'

$scriptPath = Split-Path $MyInvocation.MyCommand.Path

$gitIgnoreFilePath = Join-Path $scriptPath ".gitignore"
$items = [System.IO.File]::ReadAllLines($gitIgnoreFilePath) | foreach ($_) {$_ -replace '/'}
Get-ChildItem -Path $scriptPath -include $items -Recurse -Force | foreach ($_) {
    Write-Output "Removing item [$($_.FullName)]"
    Remove-Item $_.FullName -Recurse -Force
}