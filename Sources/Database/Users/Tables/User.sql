CREATE TABLE [dbo].[User]
(
    [UserId] INT NOT NULL IDENTITY, 
    [UserGuid] UNIQUEIDENTIFIER NOT NULL, 
    [LogonName] NVARCHAR(320) NOT NULL,
    [AccountId] INT NOT NULL, 
    [FirstName] NVARCHAR(50) NOT NULL, 
    [LastName] NVARCHAR(100) NOT NULL, 
    [MiddleName] NVARCHAR(30) NOT NULL, 
    [PasswordSalt] NVARCHAR(40) NOT NULL, 
    [PasswordHash] NVARCHAR(40) NOT NULL, 
    [PasswordChangeUtc] DATETIME2(7) NOT NULL, 
    [PasswordMustBeChanged] BIT NOT NULL, 
    [IsLogonEnabled] BIT NOT NULL, 
    [TimeZone] INT NOT NULL, 
    [CultureCode] NVARCHAR(10) NOT NULL, 
    [CreatedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
    [ModifiedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
    CONSTRAINT [User_PK] PRIMARY KEY ([UserId]), 
    CONSTRAINT [User_U_UserGuid] UNIQUE ([UserGuid]), 
    CONSTRAINT [User_U_LogonName] UNIQUE ([LogonName]), 
    CONSTRAINT [User_Account_FK] FOREIGN KEY ([AccountId]) REFERENCES [dbo].[Account]([AccountId]) 
)