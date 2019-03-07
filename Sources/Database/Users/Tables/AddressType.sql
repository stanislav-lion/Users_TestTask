CREATE TABLE [dbo].[AddressType]
(
    [AddressTypeId] INT NOT NULL, 
    [AddressTypeName] NVARCHAR(100) NOT NULL, 
    [CreatedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
    [ModifiedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
    CONSTRAINT [AddressType_PK] PRIMARY KEY ([AddressTypeId]), 
    CONSTRAINT [AddressType_U_AddressTypeName] UNIQUE ([AddressTypeName]) 
)