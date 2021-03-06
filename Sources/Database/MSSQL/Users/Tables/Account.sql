CREATE TABLE [dbo].[Account]
(
    [AccountId] INT NOT NULL IDENTITY, 
    [AccountGuid] UNIQUEIDENTIFIER NULL, 
    [AccountNumber] NVARCHAR(8) NOT NULL, 
    [AccountName] NVARCHAR(50) NOT NULL, 
    [IsEnabled] BIT NOT NULL DEFAULT 1, 
    [TimeZone] INT NULL, 
    [PasswordExpirationPeriodInDays] INT NOT NULL, 
    [DataStorageTimeHrs] INT NOT NULL, 
    [NumberOfCodeManagementApps] INT NOT NULL, 
    [CreatedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
    [ModifiedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
    CONSTRAINT [Account_PK] PRIMARY KEY CLUSTERED ([AccountId]), 
    CONSTRAINT [Account_U_AccountGuid] UNIQUE ([AccountGuid]), 
    CONSTRAINT [Account_U_AccountNumber] UNIQUE ([AccountNumber]) 
)