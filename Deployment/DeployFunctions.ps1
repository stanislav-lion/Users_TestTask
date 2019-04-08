$scriptDirectory = Split-Path $MyInvocation.MyCommand.Path

#----- Importing common functions -----
. (Join-Path $scriptDirectory CommonFunctions.ps1)
. (Join-Path $scriptDirectory DatabaseFunctions.ps1)

function GetSessions
(
    [xml] $configFile,
    [System.Management.Automation.PSCredential] $credential
)
{
    $sessions = New-Object System.Collections.HashTable
    try
    {        
        foreach ($serverName in $configFile.DeployEnvironment.DeployDatabase.DatabaseTier.ServerName)
        {
            if (-Not $sessions.Contains($serverName))
            {
                $session = New-PSSession -ComputerName $serverName -Credential $credential
                $sessions.Add($serverName, $session)
            }
        }

        foreach ($serverName in $configFile.DeployEnvironment.DeployBinaries.Tier.ServerName)
        {
            if (-Not $sessions.Contains($serverName))
            {
                $session = New-PSSession -ComputerName $serverName -Credential $credential
                $sessions.Add($serverName, $session)
            }
        }

        return $sessions
    }
    catch
    {
        Write-Warning $_

        $sessions.Values | Remove-PSSession

        throw;
    }
}

function RemoveEnvironment
(
    [string] $environmentDirectory,
    [System.Management.Automation.PSCredential] $credential
)
{
    Write-Output "Removing environment"

    if (-not (Test-Path $environmentDirectory -PathType Container))
    {
        Write-Error "Invalid environment directory [$environmentDirectory]"
    }

    if (-not $credential)
    {
        Write-Error "Invalid credentials"
    }

    $configFilePath = Join-Path $environmentDirectory "DeployConfig\DeployEnvironment.config"
    [xml]$configFile = Get-Content $configFilePath

    Write-Output "Creating remote sessions"
    $sessions = GetSessions $configFile $credential
    Write-Output "Done"
    try
    {        
        StopEnvironment $configFile $sessions
        UninstallEnvironment $configFile $sessions

        Write-Output "Environment is removed successfully"
    }
    finally
    {
        Write-Output "Removing remote sessions"
        $sessions.Values | Remove-PSSession
        Write-Output "Done"
    }
}

function DeployEnvironment
(
    [string] $environmentDirectory,
    [string] $newVersionDirectory,
    [System.Management.Automation.PSCredential] $credential
)
{
    Write-Output "Deploying environment"

    if (-not (Test-Path $environmentDirectory -PathType Container))
    {
        Write-Error "Invalid environment directory [$environmentDirectory]"
    }

    if (-not (Test-Path $newVersionDirectory -PathType Container))
    {
        Write-Error "Invalid new version directory [$newVersionDirectory]"
    }

    if (-not $credential)
    {
        Write-Error "Invalid credentials"
    }

    $configFilePath = Join-Path $environmentDirectory "DeployConfig\DeployEnvironment.config"
    [xml]$configFile = Get-Content $configFilePath
    
    Write-Output "Creating remote sessions"
    $sessions = GetSessions $configFile $credential
    Write-Output "Done"
    try
    {        
        StopEnvironment $configFile $sessions

        try
        {
            DeployDatabase $configFile $newVersionDirectory $sessions $credential
        }
        catch
        {
            Write-Warning $_

            StartEnvironment $configFile $sessions

            throw
        }

        UninstallEnvironment $configFile $sessions
        InstallEnvironment $configFile $newVersionDirectory $sessions $credential
        StartEnvironment $configFile $sessions

        Write-Output "Environment is deployed successfully"
    }
    finally
    {
        Write-Output "Removing remote sessions"
        $sessions.Values | Remove-PSSession
        Write-Output "Done"
    }
}

function StopEnvironment
(
    [xml] $configFile,
    [System.Collections.HashTable] $sessions
)
{
    Write-Output "Stopping environment"
    $tiers = $configFile.DeployEnvironment.DeployBinaries.Tier
    $tiersCount = if ($tiers) {if ($tiers.Count) {$tiers.Count} else {1}} else {0}
    for ($i=$tiersCount-1; $i -ge 0; $i--)
    {
        $tier = if ($tiers.Count) {$tiers[$i]} else {$tiers}
        foreach ($serverName in $tier.ServerName)
        {
            $session = $sessions[$serverName]

            foreach ($webApplication in $tier.WebApplication)
            {
                StopWebSite $webApplication.WebSiteName $session
            }

            foreach ($service in $tier.Service)
            {
                DisableService $service.ServiceName $session
                StopService $service.ServiceName $session                
            }
        }
    }
}

function StartEnvironment
(
    [xml] $configFile,
    [System.Collections.HashTable] $sessions
)
{
    Write-Output "Starting environment"
    $tiers = $configFile.DeployEnvironment.DeployBinaries.Tier
    $tiersCount = if ($tiers) {if ($tiers.Count) {$tiers.Count} else {1}} else {0}
    for ($i=0; $i -lt $tiersCount; $i++)
    {
        $tier = if ($tiers.Count) {$tiers[$i]} else {$tiers}
        foreach ($serverName in $tier.ServerName)
        {
            $session = $sessions[$serverName]

            foreach ($service in $tier.Service)
            {
                EnableService $service.ServiceName $session
                StartService $service.ServiceName $session
            }

            foreach ($webApplication in $tier.WebApplication)
            {
                StartWebSite $webApplication.WebSiteName $session
            }
        }
    }
}

function UninstallEnvironment
(
    [xml] $configFile,
    [System.Collections.HashTable] $sessions
)
{
    Write-Output "Uninstalling environment"
    foreach ($tier in $configFile.DeployEnvironment.DeployBinaries.Tier)
    {
        foreach ($serverName in $tier.ServerName)
        {
            $session = $sessions[$serverName]

            if ($tier.WebApplication)
            {
                foreach ($webApplication in $tier.WebApplication)
                {
                    RemoveWebApplication $webApplication.ApplicationName $webApplication.WebSiteName $session
                }

                StopIIS $session
                foreach ($webApplication in $tier.WebApplication)
                {
                    $remoteInstallPath = Join-Path $webApplication.InstallPath $webApplication.DirectoryName
                    DeleteItem $remoteInstallPath $session
                }
                StartIIS $session
            }

            foreach ($service in $tier.Service)
            {
                $remoteInstallPath = Join-Path $service.InstallPath $service.DirectoryName
                $remoteInstallExePath = Join-Path $remoteInstallPath $service.ExeName
                $is64Bit = ConvertStringToBoolean $service.Is64Bit
                UninstallService $service.ServiceName $remoteInstallExePath $is64Bit $session
                DeleteItem $remoteInstallPath $session
            }

            foreach ($copyItem in $tier.CopyItem)
            {
                $deleteOnUninstall = ConvertStringToBoolean $copyItem.DeleteOnUninstall
                if ($deleteOnUninstall)
                {
                    foreach ($itemDestinationPath in $copyItem.ItemDestinationPath)
                    {
                        $itemDestinationFullPath = Join-Path $itemDestinationPath $copyItem.ItemName
                        DeleteItem $itemDestinationFullPath $session
                    }
                }
            }

            foreach ($addValueToPathEnvironmentalVariable in $tier.AddValueToPathEnvironmentalVariable)
            {
                RemoveValueFromPathEnvironmentalVariable $addValueToPathEnvironmentalVariable $session
            }

            foreach ($copyItem in $configFile.DeployEnvironment.DeployBinaries.CopyItem)
            {
                $deleteOnUninstall = ConvertStringToBoolean $copyItem.DeleteOnUninstall
                if ($deleteOnUninstall)
                {
                    foreach ($itemDestinationPath in $copyItem.ItemDestinationPath)
                    {
                        $itemDestinationFullPath = Join-Path $itemDestinationPath $copyItem.ItemName
                        DeleteItem $itemDestinationFullPath $session
                    }
                }
            }

            foreach ($grantAuthorityAccessToDefaultRSAKeyContainer in $configFile.DeployEnvironment.DeployBinaries.GrantAuthorityAccessToDefaultRSAKeyContainer)
            {
                RevokeAccessToDefaultRSAKeyContainer $grantAuthorityAccessToDefaultRSAKeyContainer $session
            }
        }
    }
}

function InstallEnvironment
(
    [xml] $configFile,
    [string] $newVersionDirectory,
    [System.Collections.HashTable] $sessions,
    [System.Management.Automation.PSCredential] $credential
)
{
    Write-Output "Installing environment"
    foreach ($tier in $configFile.DeployEnvironment.DeployBinaries.Tier)
    {
        foreach ($serverName in $tier.ServerName)
        {
            $session = $sessions[$serverName]

            foreach ($grantAuthorityAccessToDefaultRSAKeyContainer in $configFile.DeployEnvironment.DeployBinaries.GrantAuthorityAccessToDefaultRSAKeyContainer)
            {
                GrantAccessToDefaultRSAKeyContainer $grantAuthorityAccessToDefaultRSAKeyContainer $session
            }

            foreach ($copyItem in $configFile.DeployEnvironment.DeployBinaries.CopyItem)
            {
                $newVersionDirectoryPath = Join-Path $newVersionDirectory $copyItem.ItemSourcePath
                foreach ($itemDestinationPath in $copyItem.ItemDestinationPath)
                {
                    CopyItem $newVersionDirectoryPath $itemDestinationPath $serverName $credential
                }
            }

            foreach ($addValueToPathEnvironmentalVariable in $tier.AddValueToPathEnvironmentalVariable)
            {
                AddValueToPathEnvironmentalVariable $addValueToPathEnvironmentalVariable $session
            }

            foreach ($addEventLog in $tier.AddEventLog)
            {
                CreateEventLog $addEventLog.LogName $addEventLog.SourceName $session
            }

            foreach ($service in $tier.Service)
            {
                $newVersionDirectoryPath = Join-Path $newVersionDirectory $service.DirectorySourcePath
                CopyItem $newVersionDirectoryPath $service.InstallPath $serverName $credential

                $installPath = Join-Path $service.InstallPath $service.DirectoryName
                $installExePath = Join-Path $installPath $service.ExeName
                $installConfigPath = Join-Path $installPath $service.ConfigFileName

				$settings = New-Object System.Collections.HashTable
                foreach ($generateGuidSetting in $service.ConfigOptions.GenerateGuidSetting)
                {
                    $guid = [System.Guid]::NewGuid().ToString()
					$settings.Add($generateGuidSetting.SettingName, $guid)
                }

                foreach ($modifySettingValue in $service.ConfigOptions.ModifySettingValue)
                {
					$settings.Add($modifySettingValue.SettingName, $modifySettingValue.SettingValue)
                }
                ModifyXmlFileNodesInnerText $installConfigPath $settings $session

                foreach ($protectSectionGroup in $service.ConfigOptions.ProtectSectionGroup)
                {
                    ProtectConfigSectionGroup $installConfigPath $protectSectionGroup.SectionGroupName $session
                }

                $modifyQosProfilePublicAddress = $service.ModifyQosProfilePublicAddress
                if ($modifyQosProfilePublicAddress)
                {                
                    $installQosPath = Join-Path $installPath $modifyQosProfilePublicAddress.QosFileName
                    ModifyXmlFileNodeInnerText $installQosPath $modifyQosProfilePublicAddress.PublicAddressSettingName $modifyQosProfilePublicAddress.PublicAddressSettingValue $session
                }

                $is64Bit = ConvertStringToBoolean $service.Is64Bit
                InstallService $service.ServiceName $installExePath $is64Bit $session
            }

            if ($tier.WebApplication)
            {
                foreach ($webApplication in $tier.WebApplication)
                {
                    $newVersionDirectoryPath = Join-Path $newVersionDirectory $webApplication.DirectorySourcePath
                    CopyItem $newVersionDirectoryPath $webApplication.InstallPath $serverName $credential

                    $installPath = Join-Path $webApplication.InstallPath $webApplication.DirectoryName
                    $installConfigPath = Join-Path $installPath $webApplication.ConfigFileName

				    $settings = New-Object System.Collections.HashTable
                    foreach ($generateGuidSetting in $webApplication.ConfigOptions.GenerateGuidSetting)
                    {
                        $guid = [System.Guid]::NewGuid().ToString()
					    $settings.Add($generateGuidSetting.SettingName, $guid)
                    }

                    foreach ($modifySettingValue in $webApplication.ConfigOptions.ModifySettingValue)
                    {
    					$settings.Add($modifySettingValue.SettingName, $modifySettingValue.SettingValue)
                    }
                    ModifyXmlFileNodesInnerText $installConfigPath $settings $session

                    foreach ($protectSectionGroup in $webApplication.ConfigOptions.ProtectSectionGroup)
                    {
                        ProtectConfigSectionGroup $installConfigPath $protectSectionGroup.SectionGroupName $session
                    }

                    CreateWebApplication $webApplication.ApplicationName $installPath $webApplication.WebSiteName $session
                }
                ResetIIS $session
            }

            foreach ($copyItem in $tier.CopyItem)
            {
                $newVersionDirectoryPath = Join-Path $newVersionDirectory $copyItem.ItemSourcePath
                foreach ($itemDestinationPath in $copyItem.ItemDestinationPath)
                {
                    CopyItem $newVersionDirectoryPath $itemDestinationPath $serverName $credential
                }
            }
        }
    }
}

function DeployDatabase
(
    [xml] $configFile,
    [string] $newVersionDirectory,
    [System.Collections.HashTable] $sessions,
    [System.Management.Automation.PSCredential] $credential
)
{
    $deployDatabase = $configFile.DeployEnvironment.DeployDatabase
    $serviceScriptsDirectoryPath = $deployDatabase.ServiceScriptsDirectoryPath
    $databaseBackupDirectoryPath = $deployDatabase.DatabaseBackupDirectoryPath

    # check that for each availability group there are at least two servers
    # if there is no availability group the server must be single
    foreach ($databaseTier in $deployDatabase.DatabaseTier)
    {
        $tierName = $databaseTier.TierName
        if ($databaseTier.AvailabilityGroupName)
        {
            if (-not $databaseTier.ServerName -or
                -not $databaseTier.ServerName.Count -or
                $databaseTier.ServerName.Count -lt 2)
            {
                Write-Error "Tier [$tier] must have two servers at least"
            }
        }
        else
        {
            if (-not $databaseTier.ServerName -or
                -not $databaseTier.ServerName.Count -or
                $databaseTier.ServerName.Count -ne 1)
            {
                Write-Error "Tier [$tier] must have single server"
            }
        }
    }

    # create unique server names list
    $serverNames = New-Object System.Collections.ArrayList
    foreach ($databaseTier in $deployDatabase.DatabaseTier)
    {        
        foreach ($serverName in $databaseTier.ServerName)
        {
            if (-Not $serverNames.Contains($serverName))
            {
                $serverNames.Add($serverName) >> $null
            }
        }
    }

    # copy common items
    foreach ($serverName in $serverNames)
    {        
        foreach ($copyItem in $deployDatabase.CopyItem)
        {
            $newVersionDirectoryPath = Join-Path $newVersionDirectory $copyItem.ItemSourcePath
            foreach ($itemDestinationPath in $copyItem.ItemDestinationPath)
            {
                $itemDestinationFullPath = Join-Path $itemDestinationPath $copyItem.ItemName
                DeleteItem $itemDestinationFullPath $sessions[$serverName]
                CopyItem $newVersionDirectoryPath $itemDestinationPath $serverName $credential
            }
        }
    }

    foreach ($databaseTier in $deployDatabase.DatabaseTier)
    {        
        foreach ($serverName in $databaseTier.ServerName)
        {
            # copy QoS profiles
            if ($databaseTier.CopyQosProfiles)
            {
                $newVersionDirectoryPath = Join-Path $newVersionDirectory $databaseTier.CopyQosProfiles.ItemSourcePath
                foreach ($itemDestinationPath in $databaseTier.CopyQosProfiles.ItemDestinationPath)
                {
                    $itemDestinationFullPath = Join-Path $itemDestinationPath $databaseTier.CopyQosProfiles.ItemName
                    DeleteItem $itemDestinationFullPath $sessions[$serverName]
                    CopyItem $newVersionDirectoryPath $itemDestinationPath $serverName $credential

                    # modify QoS profiles initial peer
                    $qosFileName = $databaseTier.CopyQosProfiles.QosFileName
                    $qosProfiles = Invoke-Command -Session $sessions[$serverName] -ScriptBlock {Get-ChildItem $Using:itemDestinationFullPath -Filter $Using:qosFileName -Recurse}
                    foreach ($qosProfile in $qosProfiles)
                    {
                        ModifyXmlFileNodeInnerText $qosProfile.FullName $databaseTier.CopyQosProfiles.InitialPeerSettingName $databaseTier.CopyQosProfiles.InitialPeerSettingValue $sessions[$serverName]
                    }
                }
            }

            # copy specific items
            foreach ($copyItem in $databaseTier.CopyItem)
            {
                $newVersionDirectoryPath = Join-Path $newVersionDirectory $copyItem.ItemSourcePath
                foreach ($itemDestinationPath in $copyItem.ItemDestinationPath)
                {
                    $itemDestinationFullPath = Join-Path $itemDestinationPath $copyItem.ItemName
                    DeleteItem $itemDestinationFullPath $sessions[$serverName]
                    CopyItem $newVersionDirectoryPath $itemDestinationPath $serverName $credential
                }
            }
        }
    }

    # find primary replicas
    $primaryReplicas = @{}
    foreach ($databaseTier in $deployDatabase.DatabaseTier)
    {
        $tierName = $databaseTier.TierName
        $primaryReplica = $null
        if ($databaseTier.AvailabilityGroupName)
        {
            foreach ($serverName in $databaseTier.ServerName)
            {
                $isPrimaryReplica = $null
                IsPrimaryReplica $serverName $databaseTier.AvailabilityGroupName $serviceScriptsDirectoryPath $sessions[$serverName] ([ref] $isPrimaryReplica)
                if ($isPrimaryReplica)
                {
                    $primaryReplica = $serverName
                    break
                }
            }
        }
        else
        {
            $primaryReplica = $databaseTier.ServerName
        }

        if (-not $primaryReplica)
        {
            Write-Error "Primary replica for tier [$tierName] not found"
        }

        $primaryReplicas.Add($tierName, $primaryReplica)
    }

    $newDatabases = @{}

    # backup databases    
    foreach ($databaseTier in $deployDatabase.DatabaseTier)
    {
        $isTierOwner = ConvertStringToBoolean $databaseTier.IsTierOwner
        if (-not $isTierOwner)
        {
            continue
        }

        $primaryReplica = $primaryReplicas[$databaseTier.TierName]
        foreach ($database in $databaseTier.Database)
        {
            $databaseName = $database.DatabaseName
            $backupName = Join-Path $databaseBackupDirectoryPath "$databaseName.bak"

            # remove old backup
            if (Test-Path $backupName -PathType Leaf)
            {
                Write-Output "Deleting database backup [$backupName]"
                Remove-Item $backupName -Force
            }

            $isDatabaseBackedUp = $null
            BackupDatabase $primaryReplica $databaseName $backupName $serviceScriptsDirectoryPath $sessions[$primaryReplica] ([ref] $isDatabaseBackedUp)
            if (-not $isDatabaseBackedUp)
            {
                $newDatabases.Add($databaseName, $databaseTier)
            }
        }
    }

    try
    {
        $isDeploySuccessfull = $false
        try
        {
            foreach ($databaseTier in $deployDatabase.DatabaseTier)
            {
                # execute all scripts
                foreach ($serverName in $databaseTier.ServerName)
                {
                    $preDeployScriptsDirectoryPath = Join-Path $databaseTier.DatabaseScriptsDirectoryPath "PreDeploy"
                    ExecuteSqlScripts $serverName $preDeployScriptsDirectoryPath $sessions[$serverName]
                }

                $primaryReplica = $primaryReplicas[$databaseTier.TierName]
                $deployScriptsDirectoryPath = Join-Path $databaseTier.DatabaseScriptsDirectoryPath "Deploy"
                ExecuteSqlScripts $primaryReplica $deployScriptsDirectoryPath $sessions[$primaryReplica]

                foreach ($serverName in $databaseTier.ServerName)
                {
                    $postDeployScriptsDirectoryPath = Join-Path $databaseTier.DatabaseScriptsDirectoryPath "PostDeploy"
                    ExecuteSqlScripts $serverName $postDeployScriptsDirectoryPath $sessions[$serverName]
                }
            }

            #backup newly created databases
            foreach ($newDatabase in $newDatabases.GetEnumerator())
            {
                $databaseName = $newDatabase.Key
                $databaseTier = $newDatabase.Value
                $primaryReplica = $primaryReplicas[$databaseTier.TierName]
                $backupName = Join-Path $databaseBackupDirectoryPath "$databaseName.bak"
                BackupDatabase $primaryReplica $databaseName $backupName $serviceScriptsDirectoryPath $sessions[$primaryReplica]
            }

            $isDeploySuccessfull = $true
        }
        catch
        {
            Write-Warning $_

            foreach ($databaseTier in $deployDatabase.DatabaseTier)
            {
                $isTierOwner = ConvertStringToBoolean $databaseTier.IsTierOwner
                if (-not $isTierOwner)
                {
                    continue
                }

                $primaryReplica = $primaryReplicas[$databaseTier.TierName]
                $availabilityGroupName = $databaseTier.AvailabilityGroupName
                if ($availabilityGroupName)
                {
                    # remove database from availability group 
                    foreach ($database in $databaseTier.Database)
                    {
                        $databaseName = $database.DatabaseName
                        if ($newDatabases.ContainsKey($databaseName))
                        {
                            continue
                        }

                        # remove database from availability group on secondary replicas
                        foreach ($serverName in $databaseTier.ServerName)
                        {
                            if ($primaryReplica.CompareTo($serverName))
                            {
                                RemoveDatabaseFromAvailabilityGroupOnSecondaryReplica $serverName $databaseName $serviceScriptsDirectoryPath $sessions[$serverName]
                            }
                        }

                        # remove database from availability group on primary replica
                        RemoveDatabaseFromAvailabilityGroupOnPrimaryReplica $primaryReplica $availabilityGroupName $databaseName $serviceScriptsDirectoryPath $sessions[$primaryReplica]
                    }
                }

                # drop and restore databases
                foreach ($database in $databaseTier.Database)
                {
                    $databaseName = $database.DatabaseName
                    if ($newDatabases.ContainsKey($databaseName))
                    {
                        continue
                    }

                    # drop database on all servers
                    foreach ($serverName in $databaseTier.ServerName)
                    {
                        KillSessions $serverName $databaseName $serviceScriptsDirectoryPath $sessions[$serverName]
                        DropDatabase $serverName $databaseName $serviceScriptsDirectoryPath $sessions[$serverName]
                    }

                    # restore database on primary replica
                    $backupName = Join-Path $databaseBackupDirectoryPath "$databaseName.bak"
                    RestoreDatabase $primaryReplica $databaseName $backupName $serviceScriptsDirectoryPath $sessions[$primaryReplica]

                    # enable service broker
                    $enableServiceBroker = ConvertStringToBoolean $database.EnableServiceBroker
                    if ($enableServiceBroker)
                    {
                        EnableServiceBroker $primaryReplica $databaseName $serviceScriptsDirectoryPath $sessions[$primaryReplica]
                    }
                }
            }

            throw
        }
        finally
        {
            foreach ($databaseTier in $deployDatabase.DatabaseTier)
            {
                $isTierOwner = ConvertStringToBoolean $databaseTier.IsTierOwner
                if (-not $isTierOwner)
                {
                    continue
                }

                $availabilityGroupName = $databaseTier.AvailabilityGroupName
                if ($availabilityGroupName)
                {
                    $primaryReplica = $primaryReplicas[$databaseTier.TierName]

                    # restore databases on secondary replicas if needed
                    foreach ($database in $databaseTier.Database)
                    {
                        $databaseName = $database.DatabaseName
                        if (-not $isDeploySuccessfull -and $newDatabases.ContainsKey($databaseName))
                        {
                            continue
                        }

                        $backupName = Join-Path $databaseBackupDirectoryPath "$databaseName.bak"
                        foreach ($serverName in $databaseTier.ServerName)
                        {
                            if ($primaryReplica.CompareTo($serverName))
                            {
                                RestoreDatabaseWithNoRecovery $serverName $databaseName $backupName $serviceScriptsDirectoryPath $sessions[$serverName]
                            }
                        }
                    }

                    # add databases to availability group
                    foreach ($database in $databaseTier.Database)
                    {
                        $databaseName = $database.DatabaseName
                        if (-not $isDeploySuccessfull -and $newDatabases.ContainsKey($databaseName))
                        {
                            continue
                        }

                        # add database to availability group on primary replica
                        AddDatabaseToAvailabilityGroupOnPrimaryReplica $primaryReplica $availabilityGroupName $databaseName $serviceScriptsDirectoryPath $sessions[$primaryReplica]

                        # add database to availability group on secondary replicas
                        foreach ($serverName in $databaseTier.ServerName)
                        {
                            if ($primaryReplica.CompareTo($serverName))
                            {
                                AddDatabaseToAvailabilityGroupOnSecondaryReplica $serverName $availabilityGroupName $databaseName $serviceScriptsDirectoryPath $sessions[$serverName]
                            }
                        }
                    }
                }
            }
        }
    }
    finally
    {
        # delete items after deploy
        foreach ($deleteItemAfterDeploy in $deployDatabase.DeleteItemAfterDeploy)
        {
            foreach ($serverName in $serverNames)
            {
                DeleteItem $deleteItemAfterDeploy $sessions[$serverName]
            }
        }
    }
}
