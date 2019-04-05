$ErrorActionPreference = 'Stop'

$scriptPath = Split-Path $MyInvocation.MyCommand.Path

$solutionFilePath = Join-Path $scriptPath "..\Sources\Solutions\Users.sln"

dotnet msbuild $solutionFilePath /nodeReuse:False /maxcpucount `
/property:Configuration=Release /property:Platform=All `
/property:DeployOnBuild=true /property:PublishProfile='FolderProfile.pubxml'

if ($lastexitcode)
{
    Write-Error "Build Streaming Server Solution Failed"
}