DECLARE @IsPrimaryReplica BIT = 0
IF (SELECT
        [ars].[role_desc]
    FROM
        [sys].[dm_hadr_availability_replica_states] [ars]

        INNER JOIN [sys].[availability_groups] [ag]
        ON [ag].[group_id] = [ars].[group_id]
    WHERE
        [ag].[name] = '$(AvailabilityGroupName)' AND
        [ars].[is_local] = 1) = 'PRIMARY'
BEGIN
    SET @IsPrimaryReplica = 1
END
SELECT @IsPrimaryReplica AS [IsPrimaryReplica]