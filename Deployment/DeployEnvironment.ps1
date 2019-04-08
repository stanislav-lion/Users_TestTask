param (
    [string] $environmentSuffix,
    [string] $deployUserName,
    [string] $deployUserPassword
)

$ErrorActionPreference = "Stop"

if (-not $environmentSuffix)
{
    Write-Error "Environment suffix is invalid"
}

if ((-not $deployUserName) -or (-not $deployUserPassword))
{
    Write-Error "Deploy credentials are invalid"
}

$scriptDirectory = Split-Path $MyInvocation.MyCommand.Path

#----- Importing common functions -----
. "$scriptDirectory\DeployFunctions.ps1"

$secureDeployUserPassword = ConvertTo-SecureString $deployUserPassword -AsPlainText -Force
$deployCredential = New-Object System.Management.Automation.PSCredential -ArgumentList $deployUserName, $secureDeployUserPassword

DeployEnvironment "$scriptDirectory\Environment\$environmentSuffix" $scriptDirectory $deployCredential