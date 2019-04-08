DECLARE @GroupId UNIQUEIDENTIFIER
SELECT @GroupId = [group_id] FROM [sys].[availability_groups] WHERE [name] = '$(AvailabilityGroupName)'
IF (@GroupId IS NOT NULL) AND (NOT EXISTS (SELECT 1 FROM [sys].[availability_replicas] WHERE [replica_server_name] = '$(ReplicaName)' AND [group_id] = @GroupId))
BEGIN
    ALTER AVAILABILITY GROUP [$(AvailabilityGroupName)]
    ADD REPLICA ON
    '$(ReplicaName)' WITH
        (
            ENDPOINT_URL = '$(ReplicaEndpointUrl):5022',
            AVAILABILITY_MODE = SYNCHRONOUS_COMMIT,
            FAILOVER_MODE = AUTOMATIC,
            PRIMARY_ROLE (ALLOW_CONNECTIONS = ALL),
            SECONDARY_ROLE (ALLOW_CONNECTIONS = ALL)
        )
END