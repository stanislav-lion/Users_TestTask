DECLARE @AccountAddress TABLE
(
	[AccountId] INT NOT NULL, 
	[AddressType] INT NOT NULL, 
	[AddressLine1] NVARCHAR(100) NULL, 
	[AddressLine2] NVARCHAR(100) NULL, 
	[AddressLine3] NVARCHAR(100) NULL, 
	[City] NVARCHAR(50) NOT NULL, 
	[County] NVARCHAR(50) NOT NULL, 
	[StateProvince] NVARCHAR(50) NULL, 
	[PostalCode] NVARCHAR(15) NULL, 
	[CountryTwoLetterCode] NCHAR(2) NOT NULL
)
INSERT INTO @AccountAddress
VALUES
	(1, 1, null, null, null, 'Kyiv', 'Ukraine', 'Kiev region', null, 'UA'),
	(2, 2, null, null, null, 'Kyiv', 'Ukraine', 'Kiev region', null, 'UA'),
	(3, 1, null, null, null, 'Kyiv', 'Ukraine', 'Kiev region', null, 'UA'),
	(4, 2, null, null, null, 'Kharkov', 'Ukraine', 'Kharkov region', null, 'UA'),
	(5, 1, null, null, null, 'Kharkov', 'Ukraine', 'Kharkov region', null, 'UA'),
	(6, 2, null, null, null, 'Kharkov', 'Ukraine', 'Kharkov region', null, 'UA'),
	(7, 1, null, null, null, 'Lviv', 'Ukraine', 'Lviv region', null, 'UA'),
	(8, 2, null, null, null, 'Poltava', 'Ukraine', 'Poltava region', null, 'UA'),
	(9, 1, null, null, null, 'Vinnitsa', 'Ukraine', 'Vinnitsa region', null, 'UA'),
	(10, 2, null, null, null, 'Zhitomir', 'Ukraine', 'ZhItomir region', null, 'UA')
MERGE
	[dbo].[AccountAddress] WITH (HOLDLOCK) AS [target]
USING
	@AccountAddress AS [source]
ON
	[target].[AccountId] = [source].[AccountId]
WHEN MATCHED THEN
	UPDATE SET
		[target].[AccountId] = [source].[AccountId],
		[target].[AddressType] = [source].[AddressType],
		[target].[AddressLine1] = [source].[AddressLine1],
		[target].[AddressLine2] = [source].[AddressLine2],
		[target].[AddressLine3] = [source].[AddressLine3],
		[target].[City] = [source].[City],
		[target].[County] = [source].[County],
		[target].[StateProvince] = [source].[StateProvince],
		[target].[PostalCode] = [source].[PostalCode],
		[target].[CountryTwoLetterCode] = [source].[CountryTwoLetterCode],
		[target].[CreatedUtc] = SYSUTCDATETIME(),
		[target].[ModifiedUtc] = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN
	DELETE
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[AccountId],
		[AddressType],
		[AddressLine1],
		[AddressLine2],
		[AddressLine3],
		[City],
		[County],
		[StateProvince],
		[PostalCode],
		[CountryTwoLetterCode]
	)
	VALUES
	(
		[source].[AccountId],
		[source].[AddressType],
		[source].[AddressLine1],
		[source].[AddressLine2],
		[source].[AddressLine3],
		[source].[City],
		[source].[County],
		[source].[StateProvince],
		[source].[PostalCode],
		[source].[CountryTwoLetterCode]
	);
GO