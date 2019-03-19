CREATE TABLE [dbo].[AccountAddress]
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
    [CountryTwoLetterCode] NCHAR(2) NOT NULL, 
    [CreatedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
    [ModifiedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
    CONSTRAINT [AccountAddress_PK] PRIMARY KEY ([AccountId]),
    CONSTRAINT [AccountAddress_Account_FK] FOREIGN KEY ([AccountId]) REFERENCES [dbo].[Account]([AccountId]) ON DELETE CASCADE, 
    CONSTRAINT [AccountAddress_AddressType_FK] FOREIGN KEY ([AddressType]) REFERENCES [dbo].[AddressType]([AddressTypeId]) ON DELETE CASCADE
)