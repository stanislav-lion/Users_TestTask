$ErrorActionPreference = 'Stop'

$scriptPath = Split-Path $MyInvocation.MyCommand.Path
$deploymentDirectoryPath = "$scriptPath\..\Deployment"

$items = '*.lastcodeanalysissucceeded',
         '*.CodeAnalysisLog.xml',
         '*.StaticCodeAnalysis.Results.xml',
         '*_StaticCodeAnalysisSucceededFile',
         '*.RoslynCA.json'

Get-ChildItem -Path $deploymentDirectoryPath -include $items -Recurse -Force | foreach ($_) {
    Write-Output "Removing item [$($_.FullName)]"
    Remove-Item $_.FullName -Recurse -Force
}