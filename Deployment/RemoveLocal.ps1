$ErrorActionPreference = "Stop"

$scriptDirectory = Split-Path $MyInvocation.MyCommand.Path

#----- Importing common functions -----
. (Join-Path $scriptDirectory DeployFunctions.ps1)

$credential = Get-Credential "$env:USERDOMAIN\$env:USERNAME"
RemoveEnvironment "$scriptDirectory\Environment\Local" $credential