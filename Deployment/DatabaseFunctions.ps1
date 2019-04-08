function ExecuteSqlScript
(
    [string] $dbServerName,
    [string] $scriptFileName,
    $variables,
    [System.Management.Automation.Runspaces.PSSession] $session,
    [ref] $result
)
{
    Write-Output "Executing script [$scriptFileName] on database server [$dbServerName] on computer [$($session.ComputerName)]"
    $scriptBlock = {
        $res = $null
        if ($Using:variables)
        {
            $res = Invoke-Sqlcmd -ServerInstance "$Using:dbServerName" -InputFile "$Using:scriptFileName" -Variable $Using:variables -QueryTimeout 0 -Verbose -ErrorAction Stop
        }
        else
        {
            $res = Invoke-Sqlcmd -ServerInstance "$Using:dbServerName" -InputFile "$Using:scriptFileName" -QueryTimeout 0 -Verbose -ErrorAction Stop
        }
        return $res
    }
    $res = Invoke-Command -Session $session -ScriptBlock $scriptBlock
    if ($result)
    {
        $result.Value = $res
    }
}

function ExecuteSqlScripts
(
    [string] $dbServerName,
    [string] $scriptDirectoryPath,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Executing scripts from directory [$scriptDirectoryPath] on database server [$dbServerName] on computer [$($session.ComputerName)]"
    $scriptBlock = {
        $scriptFilesMask = Join-Path $Using:scriptDirectoryPath "*.sql"
        $scriptFileNames = Get-ChildItem -Path $scriptFilesMask

        if ($scriptFileNames -And $scriptFileNames.Length -gt 0)
        {
            foreach ($scriptFileName in $scriptFileNames)
            {
                Invoke-Sqlcmd -ServerInstance "$Using:dbServerName" -InputFile "$scriptFileName" -QueryTimeout 0 -Verbose -ErrorAction Stop
            }
        }
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}

function IsPrimaryReplica
(
    [string] $dbServerName,
    [string] $availabilityGroupName,
    [string] $scriptDirectoryPath,
    [System.Management.Automation.Runspaces.PSSession] $session,
    [ref] [boolean] $isPrimaryReplica
)
{
    $scriptFileName = Join-Path $scriptDirectoryPath "IsPrimaryReplica.sql"
    $variables = "AvailabilityGroupName=$availabilityGroupName"
    $result = $null
    ExecuteSqlScript $dbServerName $scriptFileName $variables $session ([ref] $result)
    if ($isPrimaryReplica)
    {
        $isPrimaryReplica.Value = $result.IsPrimaryReplica
    }
}

function DropDatabase
(
    [string] $dbServerName,
    [string] $dbName,
    [string] $scriptDirectoryPath,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    $scriptFileName = Join-Path $scriptDirectoryPath "DropDatabase.sql"
    $variables = "DatabaseName=$dbName"
    ExecuteSqlScript $dbServerName $scriptFileName $variables $session
}

function BackupDatabase
(
    [string] $dbServerName,
    [string] $dbName,
    [string] $backupName,
    [string] $scriptDirectoryPath,
    [System.Management.Automation.Runspaces.PSSession] $session,
    [ref] [boolean] $isDatabaseBackedUp
)
{
    $scriptFileName = Join-Path $scriptDirectoryPath "BackupDatabase.sql"
    $variables = "DatabaseName=$dbName", "BackupFileName=$backupName"
    $result = $null
    ExecuteSqlScript $dbServerName $scriptFileName $variables $session ([ref] $result)
    if ($isDatabaseBackedUp)
    {
        $isDatabaseBackedUp.Value = $result.IsDatabaseBackedUp
    }
}

function RestoreDatabase
(
    [string] $dbServerName,
    [string] $dbName,
    [string] $backupName,
    [string] $scriptDirectoryPath,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    $scriptFileName = Join-Path $scriptDirectoryPath "RestoreDatabase.sql"
    $variables = "DatabaseName=$dbName", "BackupFileName=$backupName"
    ExecuteSqlScript $dbServerName $scriptFileName $variables $session
}

function RestoreDatabaseWithNoRecovery
(
    [string] $dbServerName,
    [string] $dbName,
    [string] $backupName,
    [string] $scriptDirectoryPath,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    $scriptFileName = Join-Path $scriptDirectoryPath "RestoreDatabaseWithNoRecovery.sql"
    $variables = "DatabaseName=$dbName", "BackupFileName=$backupName"
    ExecuteSqlScript $dbServerName $scriptFileName $variables $session
}

function AddDatabaseToAvailabilityGroupOnPrimaryReplica
(
    [string] $dbServerName,
    [string] $availabilityGroupName,
    [string] $dbName,
    [string] $scriptDirectoryPath,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    $scriptFileName = Join-Path $scriptDirectoryPath "AddDatabaseToAvailabilityGroupOnPrimaryReplica.sql"
    $variables = "AvailabilityGroupName=$availabilityGroupName", "DatabaseName=$dbName"
    ExecuteSqlScript $dbServerName $scriptFileName $variables $session
}

function AddDatabaseToAvailabilityGroupOnSecondaryReplica
(
    [string] $dbServerName,
    [string] $availabilityGroupName,
    [string] $dbName,
    [string] $scriptDirectoryPath,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    $scriptFileName = Join-Path $scriptDirectoryPath "AddDatabaseToAvailabilityGroupOnSecondaryReplica.sql"
    $variables = "AvailabilityGroupName=$availabilityGroupName", "DatabaseName=$dbName"
    ExecuteSqlScript $dbServerName $scriptFileName $variables $session
}

function RemoveDatabaseFromAvailabilityGroupOnPrimaryReplica
(
    [string] $dbServerName,
    [string] $availabilityGroupName,
    [string] $dbName,
    [string] $scriptDirectoryPath,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    $scriptFileName = Join-Path $scriptDirectoryPath "RemoveDatabaseFromAvailabilityGroupOnPrimaryReplica.sql"
    $variables = "AvailabilityGroupName=$availabilityGroupName", "DatabaseName=$dbName"
    ExecuteSqlScript $dbServerName $scriptFileName $variables $session
}

function RemoveDatabaseFromAvailabilityGroupOnSecondaryReplica
(
    [string] $dbServerName,
    [string] $dbName,
    [string] $scriptDirectoryPath,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    $scriptFileName = Join-Path $scriptDirectoryPath "RemoveDatabaseFromAvailabilityGroupOnSecondaryReplica.sql"
    $variables = "DatabaseName=$dbName"
    ExecuteSqlScript $dbServerName $scriptFileName $variables $session
}

function KillSessions
(
    [string] $dbServerName,
    [string] $dbName,
    [string] $scriptDirectoryPath,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    $scriptFileName = Join-Path $scriptDirectoryPath "KillSessions.sql"
    $variables = "DatabaseName=$dbName"
    ExecuteSqlScript $dbServerName $scriptFileName $variables $session
}

function EnableServiceBroker
(
    [string] $dbServerName,
    [string] $dbName,
    [string] $scriptDirectoryPath,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    $scriptFileName = Join-Path $scriptDirectoryPath "EnableServiceBroker.sql"
    $variables = "DatabaseName=$dbName"
    ExecuteSqlScript $dbServerName $scriptFileName $variables $session
}
