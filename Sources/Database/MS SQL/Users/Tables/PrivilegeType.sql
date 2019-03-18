CREATE TABLE [dbo].[PrivilegeType]
(
    [PrivilegeTypeId] TINYINT NOT NULL, 
    [PrivilegeTypeName] NVARCHAR(100) NOT NULL, 
    [CreatedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
    [ModifiedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
    CONSTRAINT [PrivilegeType_PK] PRIMARY KEY ([PrivilegeTypeId])
)