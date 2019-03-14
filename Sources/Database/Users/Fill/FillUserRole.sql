DECLARE @UserRole TABLE
(
	[UserId] INT NOT NULL, 
	[AccountRoleId] INT NOT NULL
)
INSERT INTO @UserRole
VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4),
	(5, 5),
	(6, 6),
	(7, 7),
	(8, 8),
	(9, 9),
	(10, 10)
MERGE
	[dbo].[UserRole] WITH (HOLDLOCK) AS [target]
USING
	@UserRole AS [source]
ON
	[target].[UserId] = [source].[UserId] AND 
	[target].[AccountRoleId] = [source].[AccountRoleId]
WHEN MATCHED THEN
	UPDATE SET
		[target].[UserId] = [source].[UserId],
		[target].[AccountRoleId] = [source].[AccountRoleId],
		[target].[CreatedUtc] = SYSUTCDATETIME(),
		[target].[ModifiedUtc] = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN
	DELETE
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[UserId],
		[AccountRoleId]
	)
	VALUES
	(
		[source].[UserId],
		[source].[AccountRoleId]
	);
GO