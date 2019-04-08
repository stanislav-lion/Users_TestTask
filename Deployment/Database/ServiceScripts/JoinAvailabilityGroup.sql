IF NOT EXISTS (SELECT 1 FROM [sys].[availability_groups] WHERE [name] = '$(AvailabilityGroupName)')
BEGIN
    ALTER AVAILABILITY GROUP [$(AvailabilityGroupName)] JOIN
END