DECLARE @PrivilegeType TABLE
(
	[PrivilegeTypeId] INT NOT NULL,
	[PrivilegeTypeName] NVARCHAR(100) NOT NULL
)
INSERT INTO @PrivilegeType
VALUES
	(1, 'None'),
	(2, 'View'),
	(3, 'Edit')
MERGE
	[dbo].[PrivilegeType] WITH (HOLDLOCK) AS [target]
USING
	@PrivilegeType AS [source]
ON
	[target].[PrivilegeTypeId] = [source].[PrivilegeTypeId]
WHEN MATCHED THEN
	UPDATE SET
		[target].[PrivilegeTypeName] = [source].[PrivilegeTypeName],
		[target].[ModifiedUtc] = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN
	DELETE
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[PrivilegeTypeId],
		[PrivilegeTypeName]
	)
	VALUES
	(
		[source].[PrivilegeTypeId],
		[source].[PrivilegeTypeName]
	);
GO