IF (EXISTS (SELECT 1 FROM [sys].[availability_groups] WHERE [name] = '$(AvailabilityGroupName)')) AND
   (EXISTS (SELECT 1 FROM [sys].[databases] WHERE [name] = '$(DatabaseName)' AND [replica_id] IS NULL))
BEGIN
    ALTER DATABASE [$(DatabaseName)] SET HADR AVAILABILITY GROUP = [$(AvailabilityGroupName)]
END