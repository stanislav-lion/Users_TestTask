CREATE TABLE [dbo].[AccountRole]
(
    [AccountRoleId] INT NOT NULL IDENTITY, 
    [AccountRoleGuid] UNIQUEIDENTIFIER NOT NULL, 
    [AccountId] INT NOT NULL, 
    [RoleName] NVARCHAR(40) NOT NULL, 
    [RoleTypeId] INT NOT NULL, 
    [PrivCodeManagementApp] TINYINT NOT NULL, 
    [PrivEMsApp] TINYINT NOT NULL, 
    [CreatedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
    [ModifiedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
    CONSTRAINT [AccountRole_PK] PRIMARY KEY ([AccountRoleId]), 
    CONSTRAINT [AccountRole_U_AccountRoleGuid] UNIQUE ([AccountRoleGuid]), 
    CONSTRAINT [AccountRole_Account_FK] FOREIGN KEY ([AccountId]) REFERENCES [dbo].[Account]([AccountId]) ON DELETE CASCADE, 
    CONSTRAINT [AccountRole_RoleType_FK] FOREIGN KEY ([RoleTypeId]) REFERENCES [dbo].[RoleType]([RoleTypeId]), 
    CONSTRAINT [AccountRole_PrivilegeType_FK] FOREIGN KEY ([PrivCodeManagementApp]) REFERENCES [dbo].[PrivilegeType]([PrivilegeTypeId]), 
    CONSTRAINT [AccountRole_U_AccountId_RoleName] UNIQUE ([AccountId], [RoleName]) 
)