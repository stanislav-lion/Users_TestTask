DECLARE @AccountRole TABLE
(
	[AccountRoleId] INT NOT NULL IDENTITY, 
	[AccountRoleGuid] UNIQUEIDENTIFIER NULL, 
	[AccountId] INT NOT NULL, 
	[RoleName] NVARCHAR(40) NOT NULL, 
	[RoleType] INT NOT NULL, 
	[PrivilegeType] TINYINT NOT NULL
)
INSERT INTO @AccountRole
VALUES
	(NEWID(), 1, 'Administrator', 1, 3),
	(NEWID(), 2, 'Administrator', 2, 3),
	(NEWID(), 3, 'User', 4, 3),
	(NEWID(), 4, 'Administrator', 16, 3),
	(NEWID(), 5, 'Administrator', 32, 3),
	(NEWID(), 6, 'Support', 64, 3),
	(NEWID(), 7, 'Manager', 128, 3),
	(NEWID(), 8, 'Coordinator', 256, 3),
	(NEWID(), 9, 'Specialist', 512, 2),
	(NEWID(), 10, 'Guest', 8192, 1)
MERGE
	[dbo].[AccountRole] WITH (HOLDLOCK) AS [target]
USING
	@AccountRole AS [source]
ON
	[target].[AccountRoleId] = [source].[AccountRoleId]
WHEN MATCHED THEN
	UPDATE SET
		[target].[AccountRoleGuid] = [source].[AccountRoleGuid],
		[target].[AccountId] = [source].[AccountId],
		[target].[RoleName] = [source].[RoleName],
		[target].[RoleType] = [source].[RoleType],
		[target].[PrivilegeType] = [source].[PrivilegeType],
		[target].[CreatedUtc] = SYSUTCDATETIME(),
		[target].[ModifiedUtc] = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN
	DELETE
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[AccountRoleGuid],
		[AccountId],
		[RoleName],
		[RoleType],
		[PrivilegeType]
	)
	VALUES
	(
		[source].[AccountRoleGuid],
		[source].[AccountId],
		[source].[RoleName],
		[source].[RoleType],
		[source].[PrivilegeType]
	);
GO