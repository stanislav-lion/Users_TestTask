function ConvertStringToBoolean
(
    [string] $string
)
{
    return [System.Boolean]::Parse($string)
}

function DecryptSecureString
(
    [System.Security.SecureString] $secureString
)
{
    $marshal = [System.Runtime.InteropServices.Marshal]
    $bstr = $marshal::SecureStringToBSTR($secureString)
    try
    {
        return $marshal::PtrToStringBSTR($bstr)
    }
    finally
    {
        $marshal::ZeroFreeBSTR($bstr)
    }
}

function EnableService
(
    [string] $serviceName,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Enabling service [$serviceName] on computer [$($session.ComputerName)]"
    $scriptBlock = {
        Set-Service $Using:serviceName -StartupType Automatic -PassThru -ErrorAction Stop
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}

function DisableService
(
    [string] $serviceName,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Disabling service [$serviceName] on computer [$($session.ComputerName)]"
    $scriptBlock = {
        if (Get-Service $Using:serviceName -ErrorAction SilentlyContinue)
        {
            Set-Service $Using:serviceName -StartupType Disable -PassThru
        }
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}

function StartService
(
    [string] $serviceName,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Starting service [$serviceName] on computer [$($session.ComputerName)]"
    $scriptBlock = {
        Start-Service $Using:serviceName -PassThru -ErrorAction Stop
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}

function StopService
(
    [string] $serviceName,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Stopping service [$serviceName] on computer [$($session.ComputerName)]"
    $scriptBlock = {
        if (Get-Service $Using:serviceName -ErrorAction SilentlyContinue)
        {
            Stop-Service $Using:serviceName -PassThru
        }
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}

function InstallService
(
    [string] $serviceName,
    [string] $servicePath,
    [bool] $is64Bit,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Installing service [$serviceName] with path [$servicePath] on computer [$($session.ComputerName)]"
    $scriptBlock = {
        if ($Using:is64Bit)
        {
            $command = "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\InstallUtil.exe"
        }
        else
        {
            $command = "C:\Windows\Microsoft.NET\Framework\v4.0.30319\InstallUtil.exe"
        }
        & $command "$Using:servicePath"

        if ($lastexitcode)
        {
            Write-Error "InstallService failed"
        }
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}

function UninstallService
(
    [string] $serviceName,
    [string] $servicePath,
    [bool] $is64Bit,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Uninstalling service [$serviceName] with path [$servicePath] on computer [$($session.ComputerName)]"
    $scriptBlock = {
        if ($Using:is64Bit)
        {
            $command = "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\InstallUtil.exe"
        }
        else
        {
            $command = "C:\Windows\Microsoft.NET\Framework\v4.0.30319\InstallUtil.exe"
        }
        & $command "/u" "$Using:servicePath"
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}

function StartIIS
(
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Starting IIS on computer [$($session.ComputerName)]"
    Invoke-Command -Session $session -ScriptBlock {iisreset /start}
}

function StopIIS
(
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Stopping IIS on computer [$($session.ComputerName)]"
    Invoke-Command -Session $session -ScriptBlock {iisreset /stop}
}

function ResetIIS
(
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Resetting IIS on computer [$($session.ComputerName)]"
    Invoke-Command -Session $session -ScriptBlock {iisreset}
}

function StartWebSite
(
    [string] $websiteName,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Starting website [$websiteName] on computer [$($session.ComputerName)]"
    $scriptBlock = {
        $result = Start-WebSite $Using:websiteName -PassThru -ErrorAction Stop
        $result | Select-Object -Property Name, State
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}

function StopWebSite
(
    [string] $websiteName,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Stopping website [$websiteName] on computer [$($session.ComputerName)]"
    $scriptBlock = {
        if (Get-WebSite $Using:websiteName -ErrorAction SilentlyContinue)
        {
            $result = Stop-WebSite $Using:websiteName -PassThru
            $result | Select-Object -Property Name, State
        }
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}

function CreateWebApplication
(
    [string] $webApplicationName,
    [string] $physicalPath,
    [string] $websiteName,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Creating web application [$webApplicationName] with physical path [$physicalPath] on website [$websiteName] on computer [$($session.ComputerName)]"
    $scriptBlock = {
        New-WebApplication -Name $Using:webApplicationName -PhysicalPath $Using:physicalPath -Site $Using:websiteName -ErrorAction Stop
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}

function RemoveWebApplication
(
    [string] $webApplicationName,
    [string] $websiteName,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Removing web application [$webApplicationName] on website [$websiteName] on computer [$($session.ComputerName)]"
    $scriptBlock = {
        if ((Get-WebSite $Using:websiteName -ErrorAction SilentlyContinue) -and
            (Get-WebApplication -Name $Using:webApplicationName -Site $Using:websiteName -ErrorAction SilentlyContinue))
        {
            Remove-WebApplication -Name $Using:webApplicationName -Site $Using:websiteName
        }
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}

function CopyItem
(
    [string] $sourceItemPath,
    [string] $destinationItemPath,
    [string] $computerName,
    [System.Management.Automation.PSCredential] $credential
)
{
    Write-Output "Copying item [$sourceItemPath] to [$destinationItemPath] on computer [$computerName]"

    if (-not (Test-Path $sourceItemPath))
    {
        Write-Error "Item path [$sourceItemPath] does not exist"
    }

    if (-not $destinationItemPath)
    {
        Write-Error "Item path [$destinationItemPath] is invalid"
    }

    $root = [System.IO.Path]::GetPathRoot($destinationItemPath)
    $root = $root -replace '\\$'
    $remoteRoot = $root -replace ':','$'
    $remoteRoot = "\\$computerName\$remoteRoot"

    New-PSDrive -Name X -PSProvider FileSystem -Root $remoteRoot -Credential $credential
    try
    {
        $remoteItemPath = $destinationItemPath -replace $root,'X:'
        $remoteItemDirectoryPath = $remoteItemPath

        if ((Test-Path $sourceItemPath -PathType Leaf) -and ([System.IO.Path]::GetFileName($remoteItemPath)))
        {
            $remoteItemDirectoryPath = [System.IO.Path]::GetDirectoryName($remoteItemPath)
        }

        if (-not (Test-Path $remoteItemDirectoryPath -PathType Container))
        {
            New-Item $remoteItemDirectoryPath -ItemType Directory
        }

        Copy-Item $sourceItemPath -Destination $remoteItemPath -Recurse -Force
    }
    finally
    {
        Remove-PSDrive -Name X
    }
}

function DeleteItem
(
    [string] $itemPath,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Deleting item [$itemPath] on computer [$($session.ComputerName)]"

    if (-not $itemPath)
    {
        Write-Error "Item path [$itemPath] is invalid"
        return
    }


    $scriptBlock = {
        Remove-Item $Using:itemPath -Recurse -Force -ErrorAction SilentlyContinue
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}

function ModifyXmlFileNodeInnerText
(
    [string] $xmlFilePath,
    [string] $xmlNodePath,
    [string] $xmlNodeText,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Modifying node [$xmlNodePath] inner text to value [$xmlNodeText] in xml file [$xmlFilePath] on computer [$($session.ComputerName)]"
    $scriptBlock = {
        [xml]$xml = Get-Content $Using:xmlFilePath
        $xmlNode = $xml.SelectSingleNode($Using:xmlNodePath)
        $xmlNode.InnerText = $Using:xmlNodeText
        $xml.Save($Using:xmlFilePath)
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}

function ModifyXmlFileNodesInnerText
(
    [string] $xmlFilePath,
	[System.Collections.HashTable] $nodes,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Modifying nodes in xml file [$xmlFilePath] on computer [$($session.ComputerName)]"
    $scriptBlock = {
        [xml]$xml = Get-Content $Using:xmlFilePath
        $localNodes = $Using:nodes
		foreach ($localNode in $localNodes.GetEnumerator())
		{
            Write-Output "Modifying node [$($localNode.Key)] inner text to value [$($localNode.Value)]"
			$xmlNode = $xml.SelectSingleNode($localNode.Key)
			$xmlNode.InnerText = $localNode.Value
		}
        $xml.Save($Using:xmlFilePath)
    }
    $out = Invoke-Command -Session $session -ScriptBlock $scriptBlock
    $out
}

function ProtectConfigSection
(
    [string] $configFilePath,
    [string] $sectionName,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Protecting config section [$sectionName] in file [$configFilePath] on computer [$($session.ComputerName)]"
    $scriptBlock = {
        $map = New-Object System.Configuration.ExeConfigurationFileMap
        $map.ExeConfigFilename = $Using:configFilePath
        $configuration = [System.Configuration.ConfigurationManager]::OpenMappedExeConfiguration($map, [System.Configuration.ConfigurationUserLevel]::None);
        $section = $configuration.GetSection($Using:sectionName)

        if (-not $section.SectionInformation.IsProtected)
        {
            $section.SectionInformation.ProtectSection("RsaProtectedConfigurationProvider")
            $configuration.Save([System.Configuration.ConfigurationSaveMode]::Full)
        }
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}

function UnprotectConfigSection
(
    [string] $configFilePath,
    [string] $sectionName,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Unprotecting config section [$sectionName] in file [$configFilePath] on computer [$($session.ComputerName)]"
    $scriptBlock = {
        $map = New-Object System.Configuration.ExeConfigurationFileMap
        $map.ExeConfigFilename = $Using:configFilePath
        $configuration = [System.Configuration.ConfigurationManager]::OpenMappedExeConfiguration($map, [System.Configuration.ConfigurationUserLevel]::None);
        $section = $configuration.GetSection($Using:sectionName)

        if ($section.SectionInformation.IsProtected)
        {
            $section.SectionInformation.UnprotectSection()
            $configuration.Save([System.Configuration.ConfigurationSaveMode]::Full)
        }
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}

function ProtectConfigSectionGroup
(
    [string] $configFilePath,
    [string] $sectionGroupName,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Protecting config section group [$sectionGroupName] in file [$configFilePath] on computer [$($session.ComputerName)]"
    $scriptBlock = {
        $map = New-Object System.Configuration.ExeConfigurationFileMap
        $map.ExeConfigFilename = $Using:configFilePath
        $configuration = [System.Configuration.ConfigurationManager]::OpenMappedExeConfiguration($map, [System.Configuration.ConfigurationUserLevel]::None);
        $sectionGroup = $configuration.GetSectionGroup($Using:sectionGroupName)
        foreach ($section in $sectionGroup.Sections)
        {
            if (-not $section.SectionInformation.IsProtected)
            {                
                Write-Output "Protecting config section [$($section.SectionInformation.Name)]"
                $section.SectionInformation.ProtectSection("RsaProtectedConfigurationProvider")
            }
        }
        $configuration.Save([System.Configuration.ConfigurationSaveMode]::Full)
    }
    $out = Invoke-Command -Session $session -ScriptBlock $scriptBlock
    $out
}

function UnprotectConfigSectionGroup
(
    [string] $configFilePath,
    [string] $sectionGroupName,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Unprotecting config section group [$sectionGroupName] in file [$configFilePath] on computer [$($session.ComputerName)]"
    $scriptBlock = {
        $map = New-Object System.Configuration.ExeConfigurationFileMap
        $map.ExeConfigFilename = $Using:configFilePath
        $configuration = [System.Configuration.ConfigurationManager]::OpenMappedExeConfiguration($map, [System.Configuration.ConfigurationUserLevel]::None);
        $sectionGroup = $configuration.GetSectionGroup($Using:sectionGroupName)
        foreach ($section in $sectionGroup.Sections)
        {
            if ($section.SectionInformation.IsProtected)
            {
                Write-Output "Unprotecting config section [$($section.SectionInformation.Name)]"
                $section.SectionInformation.UnprotectSection()
            }
        }
        $configuration.Save([System.Configuration.ConfigurationSaveMode]::Full)
    }
    $out = Invoke-Command -Session $session -ScriptBlock $scriptBlock
    $out
}

function AddValueToPathEnvironmentalVariable
(
    [string] $addValue,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    $variableName = "Path"
    Write-Output "Adding value [$addValue] to the [$variableName] environmental variable on computer [$($session.ComputerName)]"
    $scriptBlock = {
        $variableValue = [Environment]::GetEnvironmentVariable($Using:variableName, "Machine")
        if (-not $variableValue.ToLower().Contains(($Using:addValue).ToLower()))
        {
            $semicolon = ";"
            if ($variableValue.EndsWith($semicolon))
            {
                $semicolon = ""
            }
            $variableValue = $variableValue + $semicolon + $Using:addValue
            [Environment]::SetEnvironmentVariable($Using:variableName, $variableValue, "Machine")
        }
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}

function RemoveValueFromPathEnvironmentalVariable
(
    [string] $removeValue,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    $variableName = "Path"
    Write-Output "Removing value [$removeValue] from the [$variableName] environmental variable on computer [$($session.ComputerName)]"
    $scriptBlock = {
        $variableValue = [Environment]::GetEnvironmentVariable($Using:variableName, "Machine")
        if ($variableValue.ToLower().Contains(($Using:removeValue).ToLower()))
        {
            $variableValue = $variableValue.Replace($Using:removeValue, "")
            [Environment]::SetEnvironmentVariable($Using:variableName, $variableValue, "Machine")
        }
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}

function AddAssemblyToGAC
(
    [string] $assemblyPath,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Adding assembly with path [$assemblyPath] to GAC on computer [$($session.ComputerName)]"
    $scriptBlock = {
        [System.Reflection.Assembly]::Load("System.EnterpriseServices, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")
        $publish = New-Object System.EnterpriseServices.Internal.Publish
        $publish.GacInstall($Using:assemblyPath)
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}

function RemoveAssemblyFromGAC
(
    [string] $assemblyPath,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Removing assembly with path [$assemblyPath] to GAC on computer [$($session.ComputerName)]"
    $scriptBlock = {
        [System.Reflection.Assembly]::Load("System.EnterpriseServices, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")
        $publish = New-Object System.EnterpriseServices.Internal.Publish
        $publish.GacRemove($Using:assemblyPath)
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}

function GrantAccessToDefaultRSAKeyContainer
(
    [string] $authorityName,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Granting authority [$authorityName] access to the default RSA key container on computer [$($session.ComputerName)]"
    $scriptBlock = {
        $command = "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\aspnet_regiis.exe"

        & $command "-pc" "NetFrameworkConfigurationKey" "-exp"

        & $command "-pa" "NetFrameworkConfigurationKey" "$Using:authorityName"
        
        if ($lastexitcode)
        {
            Write-Error "GrantAccessToDefaultRSAKeyContainer failed"
        }
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}

function RevokeAccessToDefaultRSAKeyContainer
(
    [string] $authorityName,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Revoking authority [$authorityName] access to the default RSA key container on computer [$($session.ComputerName)]"
    $scriptBlock = {
        $command = "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\aspnet_regiis.exe"
        & $command "-pr" "NetFrameworkConfigurationKey" "$Using:authorityName"
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}

function CreateEventLog
(
    [string] $eventLogName,
    [string] $eventLogSourceName,
    [System.Management.Automation.Runspaces.PSSession] $session
)
{
    Write-Output "Creating event log source [$eventLogSourceName] in the log [$eventLogName] on computer [$($session.ComputerName)]"
    $scriptBlock = {
        if (![System.Diagnostics.EventLog]::SourceExists($Using:eventLogSourceName))
        {
            [System.Diagnostics.EventLog]::CreateEventSource($Using:eventLogSourceName, $Using:eventLogName)
        }        
    }
    Invoke-Command -Session $session -ScriptBlock $scriptBlock
}
