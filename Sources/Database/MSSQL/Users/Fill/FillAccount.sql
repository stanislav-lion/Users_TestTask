DECLARE @Account TABLE
(
	[AccountId] INT NOT NULL IDENTITY, 
	[AccountGuid] UNIQUEIDENTIFIER NULL, 
	[AccountNumber] NVARCHAR(8) NOT NULL, 
	[AccountName] NVARCHAR(50) NOT NULL, 
	[IsEnabled] BIT NOT NULL DEFAULT 1, 
	[TimeZone] INT NULL, 
	[PasswordExpirationPeriodInDays] INT NOT NULL, 
	[DataStorageTimeHrs] INT NOT NULL, 
	[NumberOfCodeManagementApps] INT NOT NULL
)
INSERT INTO @Account
VALUES
	(NEWID(), 'Number1', 'Stanislav Account', 1, 2, 3, 60, 1),
	(NEWID(), 'Number2', 'Andrew Account', 1, 2, 3, 60, 1),
	(NEWID(), 'Number3', 'Sergei Account', 1, 2, 3, 60, 1),
	(NEWID(), 'Number4', 'Alexander Account', 1, 2, 3, 60, 1),
	(NEWID(), 'Number5', 'Ivan Account', 1, 2, 3, 60, 1),
	(NEWID(), 'Number6', 'Luda Account', 1, 2, 3, 60, 1),
	(NEWID(), 'Number7', 'Karina Account', 1, 2, 3, 60, 1),
	(NEWID(), 'Number8', 'Lena Account', 1, 2, 3, 60, 1),
	(NEWID(), 'Number9', 'Nastya Account', 1, 2, 3, 60, 1),
	(NEWID(), 'Number10', 'Irina Account', 1, 2, 3, 60, 1)
MERGE
	[dbo].[Account] WITH (HOLDLOCK) AS [target]
USING
	@Account AS [source]
ON
	[target].[AccountId] = [source].[AccountId]
WHEN MATCHED THEN
	UPDATE SET
		[target].[AccountGuid] = [source].[AccountGuid],
		[target].[AccountNumber] = [source].[AccountNumber],
		[target].[AccountName] = [source].[AccountName],
		[target].[IsEnabled] = [source].[IsEnabled],
		[target].[TimeZone] = [source].[TimeZone],
		[target].[PasswordExpirationPeriodInDays] = [source].[PasswordExpirationPeriodInDays],
		[target].[DataStorageTimeHrs] = [source].[DataStorageTimeHrs],
		[target].[NumberOfCodeManagementApps] = [source].[NumberOfCodeManagementApps],
		[target].[CreatedUtc] = SYSUTCDATETIME(),
		[target].[ModifiedUtc] = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN
	DELETE
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[AccountGuid],
		[AccountNumber],
		[AccountName],
		[IsEnabled],
		[TimeZone],
		[PasswordExpirationPeriodInDays],
		[DataStorageTimeHrs],
		[NumberOfCodeManagementApps]
	)
	VALUES
	(
		[source].[AccountGuid],
		[source].[AccountNumber],
		[source].[AccountName],
		[source].[IsEnabled],
		[source].[TimeZone],
		[source].[PasswordExpirationPeriodInDays],
		[source].[DataStorageTimeHrs],
		[source].[NumberOfCodeManagementApps]
	);
GO