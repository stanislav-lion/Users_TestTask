CREATE TABLE [dbo].[User]
(
	[UserId] INT NOT NULL IDENTITY, 
	[UserGuid] UNIQUEIDENTIFIER NULL, 
	[LogonName] NVARCHAR(100) NOT NULL,
	[AccountId] INT NOT NULL, 
	[FirstName] NVARCHAR(50) NOT NULL, 
	[LastName] NVARCHAR(100) NOT NULL, 
	[MiddleName] NVARCHAR(30) NULL, 
	[PasswordSalt] NVARCHAR(30) NOT NULL, 
	[PasswordHash] NVARCHAR(30) NOT NULL, 
	[PasswordChangeUtc] DATETIME2(7) NULL, 
	[PasswordMustBeChanged] BIT NOT NULL DEFAULT 1, 
	[IsLogonEnabled] BIT NOT NULL DEFAULT 1, 
	[TimeZone] INT NULL, 
	[CultureCode] NVARCHAR(10) NULL, 
	[CreatedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
	[ModifiedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
	CONSTRAINT [User_PK] PRIMARY KEY ([UserId]), 
	CONSTRAINT [User_U_UserGuid] UNIQUE ([UserGuid]), 
	CONSTRAINT [User_U_LogonName] UNIQUE ([LogonName]), 
	CONSTRAINT [User_U_AccountId] UNIQUE ([AccountId]), 
	CONSTRAINT [User_Account_FK] FOREIGN KEY ([AccountId]) REFERENCES [dbo].[Account]([AccountId])
)