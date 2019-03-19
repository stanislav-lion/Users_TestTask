DECLARE @RoleType TABLE
(
	[RoleTypeId] INT NOT NULL,
	[RoleTypeName] NVARCHAR(100) NOT NULL
)
INSERT INTO @RoleType
VALUES
	(0x0001,     'APPLICATION_ADMINISTRATOR'),
	(0x0002,     'COMPANY_ADMINISTRATOR'),
	(0x0004,     'COMPANY_USER'),
	(0x0010,     'SYSTEM_ADMINISTRATOR'),
	(0x0020,     'ACCOUNT_ADMINISTRATOR'),
	(0x0040,     'ACCOUNT_SUPPORT'),
	(0x0080,     'NETWORK_MANAGER'),
	(0x00000100, 'SITE_COORDINATOR'),
	(0x00000200, 'SERVICE_SPECIALIST'),
	(0x00002000, 'GUEST')
MERGE
	[dbo].[RoleType] WITH (HOLDLOCK) AS [target]
USING
	@RoleType AS [source]
ON
	[target].[RoleTypeId] = [source].[RoleTypeId]
WHEN MATCHED THEN
	UPDATE SET
		[target].[RoleTypeName] = [source].[RoleTypeName],
		[target].[ModifiedUtc] = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN
	DELETE
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[RoleTypeId],
		[RoleTypeName]
	)
	VALUES
	(
		[source].[RoleTypeId],
		[source].[RoleTypeName]
	);
GO