$Password = Read-Host "Enter password"
$ScriptDirectory = Split-Path $MyInvocation.MyCommand.Path

$PasswordValueFile = Join-Path $ScriptDirectory password.val
$PasswordKeyFile = Join-Path $ScriptDirectory password.key

$Key = New-Object Byte[] 32
[Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($Key)
$Key | Out-File $PasswordKeyFile

$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force
$SecurePassword | ConvertFrom-SecureString -key $Key | Out-File $PasswordValueFile