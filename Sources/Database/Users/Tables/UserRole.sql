CREATE TABLE [dbo].[UserRole]
(
    [UserId] INT NOT NULL, 
    [AccountRoleId] INT NOT NULL, 
    [CreatedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
    [ModifiedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
    CONSTRAINT [UserRole_PK] PRIMARY KEY ([UserId], [AccountRoleId]), 
    CONSTRAINT [UserRole_User_FK] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User]([UserId]) ON DELETE CASCADE, 
    CONSTRAINT [UserRole_AccountRole_FK] FOREIGN KEY ([AccountRoleId]) REFERENCES [dbo].[AccountRole]([AccountRoleId]) ON DELETE CASCADE
)