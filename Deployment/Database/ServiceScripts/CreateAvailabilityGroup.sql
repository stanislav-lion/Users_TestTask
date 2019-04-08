IF NOT EXISTS (SELECT 1 FROM [sys].[availability_groups] WHERE [name] = '$(AvailabilityGroupName)')
BEGIN
    CREATE AVAILABILITY GROUP [$(AvailabilityGroupName)]
    FOR REPLICA ON
        '$(ReplicaName)' WITH
            (
                ENDPOINT_URL = '$(ReplicaEndpointUrl):5022',
                AVAILABILITY_MODE = SYNCHRONOUS_COMMIT,
                FAILOVER_MODE = AUTOMATIC,
                PRIMARY_ROLE (ALLOW_CONNECTIONS = ALL),
                SECONDARY_ROLE (ALLOW_CONNECTIONS = ALL)
            )
    LISTENER '$(ListenerName)'
    (
        WITH
            IP (('$(ListenerIP)','$(ListenerSubnet)')),
            PORT = $(ListenerPort)
    )
END