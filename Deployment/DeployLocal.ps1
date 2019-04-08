$ErrorActionPreference = "Stop"

$scriptDirectory = Split-Path $MyInvocation.MyCommand.Path

$databaseBackupDirectoryPath = 'D:\DbBackup'
$sqlDataDirectoryPath = 'D:\SQLData'
$directoriesToCreate = $databaseBackupDirectoryPath,
                       $sqlDataDirectoryPath

$directoriesToCreate | foreach { if (-not (Test-Path $_ -PathType Container)) { New-Item -ItemType Directory -Path $_ } }

$credential = Get-Credential "$env:USERDOMAIN\$env:USERNAME"
$userName = $credential.UserName
$bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($credential.Password)
$password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
if (-not $password)
{
    Write-Error "Invalid password"
}

Invoke-Expression "$scriptDirectory\DeployEnvironment.ps1 Local $userName $password"