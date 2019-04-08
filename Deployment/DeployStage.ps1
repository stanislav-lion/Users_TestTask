$ErrorActionPreference = "Stop"

$scriptDirectory = Split-Path $MyInvocation.MyCommand.Path

Invoke-Expression "$scriptDirectory\DeployEnvironment.ps1 STAGE $Env:STAGE_DEPLOY_USERNAME $Env:STAGE_DEPLOY_USERPASSWORD"