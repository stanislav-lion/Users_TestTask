DECLARE @User TABLE
(
	[UserId] INT NOT NULL IDENTITY, 
	[UserGuid] UNIQUEIDENTIFIER NULL, 
	[LogonName] NVARCHAR(100) NOT NULL,
	[AccountId] INT NULL, 
	[FirstName] NVARCHAR(50) NOT NULL, 
	[LastName] NVARCHAR(100) NOT NULL, 
	[MiddleName] NVARCHAR(30) NULL, 
	[PasswordSalt] NVARCHAR(40) NULL, 
	[PasswordHash] NVARCHAR(40) NULL, 
	[PasswordMustBeChanged] BIT NULL, 
	[IsLogonEnabled] BIT NULL, 
	[TimeZone] INT NULL, 
	[CultureCode] NVARCHAR(10) NULL
)
INSERT INTO @User
VALUES
	(NEWID(), 'stanislav_lion', 1, 'Stanislav', 'Zrozhevskyi', null, 'test', 'test', 0, 1, 2, 'uk-UA'),
	(NEWID(), 'andrew', 2, 'Andrew', 'Dvornichenko', null, 'test', 'test', 0, 1, 2, 'uk-UA'),
	(NEWID(), 'sergei', 3, 'Sergei', 'Podolyanchuk', null, 'test', 'test', 0, 1, 2, 'uk-UA'),
	(NEWID(), 'alexander', 4, 'Alexander', 'Ostrovskyi', null, 'test', 'test', 0, 1, 2, 'uk-UA'),
	(NEWID(), 'ivan', 5, 'Ivan', 'Ponomarev', null, 'test', 'test', 0, 1, 2, 'uk-UA'),
	(NEWID(), 'luda', 6, 'Luda', 'Osovskaya', null, 'test', 'test', 0, 1, 2, 'uk-UA'),
	(NEWID(), 'karina', 7, 'Karina', 'Nosova', null, 'test', 'test', 0, 1, 2, 'uk-UA'),
	(NEWID(), 'lena', 8, 'Lena', 'Glushankova', null, 'test', 'test', 0, 1, 2, 'uk-UA'),
	(NEWID(), 'nastya', 9, 'Nastya', 'Kaluzhnaya', null, 'test', 'test', 0, 1, 2, 'uk-UA'),
	(NEWID(), 'irina', 10, 'Irina', 'Alekseevna', null, 'test', 'test', 0, 1, 2, 'uk-UA')
MERGE
	[dbo].[User] WITH (HOLDLOCK) AS [target]
USING
	@User AS [source]
ON
	[target].[UserId] = [source].[UserId]
WHEN MATCHED THEN
	UPDATE SET
		[target].[UserGuid] = [source].[UserGuid],
		[target].[LogonName] = [source].[LogonName],
		[target].[AccountId] = [source].[AccountId],
		[target].[FirstName] = [source].[FirstName],
		[target].[LastName] = [source].[LastName],
		[target].[MiddleName] = [source].[MiddleName],
		[target].[PasswordSalt] = [source].[PasswordSalt],
		[target].[PasswordHash] = [source].[PasswordHash],
		[target].[PasswordMustBeChanged] = [source].[PasswordMustBeChanged],
		[target].[IsLogonEnabled] = [source].[IsLogonEnabled],
		[target].[TimeZone] = [source].[TimeZone],
		[target].[CultureCode] = [source].[CultureCode],
		[target].[CreatedUtc] = SYSUTCDATETIME(),
		[target].[ModifiedUtc] = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN
	DELETE
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[UserGuid],
		[LogonName],
		[AccountId],
		[FirstName],
		[LastName],
		[MiddleName],
		[PasswordSalt],
		[PasswordHash],
		[PasswordMustBeChanged],
		[IsLogonEnabled],
		[TimeZone],
		[CultureCode]
	)
	VALUES
	(
		[source].[UserGuid],
		[source].[LogonName],
		[source].[AccountId],
		[source].[FirstName],
		[source].[LastName],
		[source].[MiddleName],
		[source].[PasswordSalt],
		[source].[PasswordHash],
		[source].[PasswordMustBeChanged],
		[source].[IsLogonEnabled],
		[source].[TimeZone],
		[source].[CultureCode]
	);
GO