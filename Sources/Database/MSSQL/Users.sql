IF NOT EXISTS (SELECT * FROM sys.databases 
	WHERE name = N'Users')
BEGIN
	CREATE DATABASE [Users]
END
GO

USE [Users]
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[UserRole]') AND TYPE IN (N'U'))
BEGIN
	DROP TABLE [dbo].[UserRole]
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AccountAddress]') AND TYPE IN (N'U'))
BEGIN
	DROP TABLE [dbo].[AccountAddress]
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AddressType]') AND TYPE IN (N'U'))
BEGIN
	DROP TABLE [dbo].[AddressType]
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AccountRole]') AND TYPE IN (N'U'))
BEGIN
	DROP TABLE [dbo].[AccountRole]
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[RoleType]') AND TYPE IN (N'U'))
BEGIN
	DROP TABLE [dbo].[RoleType]
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[PrivilegeType]') AND TYPE IN (N'U'))
BEGIN
	DROP TABLE [dbo].[PrivilegeType]
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[User]') AND TYPE IN (N'U'))
BEGIN
	DROP TABLE [dbo].[User]
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[Account]') AND TYPE IN (N'U'))
BEGIN
	DROP TABLE [dbo].[Account]
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[Account]') AND TYPE IN (N'U'))
BEGIN
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
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AddressType]') AND TYPE IN (N'U'))
BEGIN
	CREATE TABLE [dbo].[AddressType]
	(
		[AddressTypeId] INT NOT NULL, 
		[AddressTypeName] NVARCHAR(100) NOT NULL, 
		[CreatedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
		[ModifiedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
		CONSTRAINT [AddressType_PK] PRIMARY KEY ([AddressTypeId]), 
		CONSTRAINT [AddressType_U_AddressTypeName] UNIQUE ([AddressTypeName]) 
	)
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AccountAddress]') AND TYPE IN (N'U'))
BEGIN
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
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[RoleType]') AND TYPE IN (N'U'))
BEGIN
	CREATE TABLE [dbo].[RoleType]
	(
		[RoleTypeId] INT NOT NULL, 
		[RoleTypeName] NVARCHAR(100) NOT NULL, 
		[CreatedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
		[ModifiedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
		CONSTRAINT [RoleType_PK] PRIMARY KEY ([RoleTypeId])
	)
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[PrivilegeType]') AND TYPE IN (N'U'))
BEGIN
	CREATE TABLE [dbo].[PrivilegeType]
	(
		[PrivilegeTypeId] TINYINT NOT NULL, 
		[PrivilegeTypeName] NVARCHAR(100) NOT NULL, 
		[CreatedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
		[ModifiedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
		CONSTRAINT [PrivilegeType_PK] PRIMARY KEY ([PrivilegeTypeId])
	)
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AccountRole]') AND TYPE IN (N'U'))
BEGIN
	CREATE TABLE [dbo].[AccountRole]
	(
		[AccountRoleId] INT NOT NULL IDENTITY, 
		[AccountRoleGuid] UNIQUEIDENTIFIER NULL, 
		[AccountId] INT NOT NULL, 
		[RoleName] NVARCHAR(40) NOT NULL, 
		[RoleType] INT NOT NULL, 
		[PrivilegeType] TINYINT NOT NULL, 
		[CreatedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
		[ModifiedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
		CONSTRAINT [AccountRole_PK] PRIMARY KEY ([AccountRoleId]), 
		CONSTRAINT [AccountRole_U_AccountRoleGuid] UNIQUE ([AccountRoleGuid]), 
		CONSTRAINT [AccountRole_U_AccountId] UNIQUE ([AccountId]), 
		CONSTRAINT [AccountRole_U_AccountId_RoleName] UNIQUE ([AccountId], [RoleName]), 
		CONSTRAINT [AccountRole_U_AccountId_RoleType] UNIQUE ([AccountId], [RoleType]), 
		CONSTRAINT [AccountRole_Account_FK] FOREIGN KEY ([AccountId]) REFERENCES [dbo].[Account]([AccountId]) ON DELETE CASCADE, 
		CONSTRAINT [AccountRole_RoleType_FK] FOREIGN KEY ([RoleType]) REFERENCES [dbo].[RoleType]([RoleTypeId]), 
		CONSTRAINT [AccountRole_PrivilegeType_FK] FOREIGN KEY ([PrivilegeType]) REFERENCES [dbo].[PrivilegeType]([PrivilegeTypeId])
	)
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[User]') AND TYPE IN (N'U'))
BEGIN
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
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[UserRole]') AND TYPE IN (N'U'))
BEGIN
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
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AccountSelectByGuid]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[AccountSelectByGuid]
GO

CREATE PROCEDURE [dbo].[AccountSelectByGuid]
(
    @AccountGuid UNIQUEIDENTIFIER
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        [AccountId],
        [AccountGuid],
        [AccountNumber],
        [AccountName],
        [IsEnabled],
        [TimeZone],
        [PasswordExpirationPeriodInDays],
        [DataStorageTimeHrs],
        [NumberOfCodeManagementApps]
    FROM
        [dbo].[Account]
    WHERE
        [AccountGuid] = @AccountGuid
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AccountSelectById]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[AccountSelectById]
GO

CREATE PROCEDURE [dbo].[AccountSelectById]
(
    @AccountId INT
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        [AccountId],
        [AccountGuid],
        [AccountNumber],
        [AccountName],
        [IsEnabled],
        [TimeZone],
        [PasswordExpirationPeriodInDays],
        [DataStorageTimeHrs],
        [NumberOfCodeManagementApps]
    FROM
        [dbo].[Account]
    WHERE
        [AccountId] = @AccountId
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AccountSelectIdByGuid]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[AccountSelectIdByGuid]
GO

CREATE PROCEDURE [dbo].[AccountSelectIdByGuid]
(
    @AccountGuid UNIQUEIDENTIFIER,
    @AccountId INT OUT
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        @AccountId = [AccountId]
    FROM
        [dbo].[Account]
    WHERE
        [AccountGuid] = @AccountGuid
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AccountSelectIdByNumber]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[AccountSelectIdByNumber]
GO

CREATE PROCEDURE [dbo].[AccountSelectIdByNumber]
(
    @AccountNumber NVARCHAR(8),
    @AccountId INT OUT
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        @AccountId = [AccountId]
    FROM
        [dbo].[Account]
    WHERE
        [AccountNumber] = @AccountNumber
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AccountUpsert]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[AccountUpsert]
GO

CREATE PROCEDURE [dbo].[AccountUpsert]
(
    @AccountGuid UNIQUEIDENTIFIER,
    @AccountNumber NVARCHAR(8),
    @AccountName NVARCHAR(56),
    @IsEnabled BIT,
    @TimeZone INT,
    @PasswordExpirationPeriodInDays INT,
    @DataStorageTimeHrs INT,
    @NumberOfCodeManagementApps INT,
    @AccountId INT OUT
)
AS
BEGIN
    SET NOCOUNT ON

    MERGE
        [dbo].[Account] WITH (HOLDLOCK) AS [target]
    USING
        (
            SELECT
                @AccountGuid,
                @AccountNumber,
                @AccountName,
                @IsEnabled,
                @TimeZone,
                @PasswordExpirationPeriodInDays,
                @DataStorageTimeHrs,
                @NumberOfCodeManagementApps
        )
        AS [source]
        (
            [AccountGuid],
            [AccountNumber],
            [AccountName],
            [IsEnabled],
            [TimeZone],
            [PasswordExpirationPeriodInDays],
            [DataStorageTimeHrs],
            [NumberOfCodeManagementApps]
        )
    ON
        [target].[AccountGuid] = [source].[AccountGuid]
    WHEN MATCHED THEN
        UPDATE SET
            @AccountId = [target].[AccountId],
            [target].[AccountNumber] = [source].[AccountNumber],
            [target].[AccountName] = [source].[AccountName],
            [target].[IsEnabled] = [source].[IsEnabled],
            [target].[TimeZone] = [source].[TimeZone],
            [target].[PasswordExpirationPeriodInDays] = [source].[PasswordExpirationPeriodInDays],
            [target].[DataStorageTimeHrs] = [source].[DataStorageTimeHrs],
            [target].[NumberOfCodeManagementApps] = [source].[NumberOfCodeManagementApps],
            [target].[ModifiedUtc] = SYSUTCDATETIME()
    WHEN NOT MATCHED THEN
        INSERT
        (
            [AccountGuid],
            [AccountNumber],
            [AccountName],
            [IsEnabled],
            [TimeZone],
            [PasswordExpirationPeriodInDays],
            [DataStorageTimeHrs],
            [NumberOfCodeManagementApps]
        )
        VALUES
        (
            [source].[AccountGuid],
            [source].[AccountNumber],
            [source].[AccountName],
            [source].[IsEnabled],
            [source].[TimeZone],
            [source].[PasswordExpirationPeriodInDays],
            [source].[DataStorageTimeHrs],
            [source].[NumberOfCodeManagementApps]
        );

    SET @AccountId = ISNULL(@AccountId, SCOPE_IDENTITY())
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AccountAddressSelect]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[AccountAddressSelect]
GO

CREATE PROCEDURE [dbo].[AccountAddressSelect]
(
    @AccountId INT
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
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
    FROM
        [dbo].[AccountAddress]
    WHERE
        [AccountId] = @AccountId
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AccountAddressUpsert]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[AccountAddressUpsert]
GO

CREATE PROCEDURE [dbo].[AccountAddressUpsert]
(
    @AccountId INT,
    @AddressType INT,
    @AddressLine1 NVARCHAR(100),
    @AddressLine2 NVARCHAR(100),
    @AddressLine3 NVARCHAR(100),
    @City NVARCHAR(100),
    @County NVARCHAR(100),
    @StateProvince NVARCHAR(50) = NULL,
    @PostalCode NVARCHAR(15),
    @CountryTwoLetterCode NCHAR(2)
)
AS
BEGIN
    SET NOCOUNT ON

    MERGE
        [dbo].[AccountAddress] WITH (HOLDLOCK) AS [target]
    USING
        (
            SELECT
                @AccountId,
                @AddressType,
                @AddressLine1,
                @AddressLine2,
                @AddressLine3,
                @City,
                @County,
                @StateProvince,
                @PostalCode,
                @CountryTwoLetterCode
        )
        AS [source]
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
    ON
        [target].[AccountId] = [source].[AccountId]
    WHEN MATCHED THEN
        UPDATE SET
            [target].[AddressType] = [source].[AddressType],
            [target].[AddressLine1] = [source].[AddressLine1],
            [target].[AddressLine2] = [source].[AddressLine2],
            [target].[AddressLine3] = [source].[AddressLine3],
            [target].[City] = [source].[City],
            [target].[County] = [source].[County],
            [target].[StateProvince] = [source].[StateProvince],
            [target].[PostalCode] = [source].[PostalCode],
            [target].[CountryTwoLetterCode] = [source].[CountryTwoLetterCode],
            [target].[ModifiedUtc] = SYSUTCDATETIME()
    WHEN NOT MATCHED THEN
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
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AccountRoleDeleteByAccountId]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[AccountRoleDeleteByAccountId]
GO

CREATE PROCEDURE [dbo].[AccountRoleDeleteByAccountId]
(
    @AccountId INT
)
AS
BEGIN
    SET NOCOUNT ON

    DELETE FROM [dbo].[AccountRole]
    WHERE [AccountId] = @AccountId
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AccountRoleDeleteById]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[AccountRoleDeleteById]
GO

CREATE PROCEDURE [dbo].[AccountRoleDeleteById]
(
    @AccountRoleId INT
)
AS
BEGIN
    SET NOCOUNT ON

    DELETE FROM [dbo].[AccountRole]
    WHERE [AccountRoleId] = @AccountRoleId
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AccountRoleSelectByAccountId]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[AccountRoleSelectByAccountId]
GO

CREATE PROCEDURE [dbo].[AccountRoleSelectByAccountId]
(
    @AccountId INT
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        [AccountRoleId],
        [AccountRoleGuid],
        [AccountId],
        [RoleName],
        [RoleType],
        [PrivilegeType]
    FROM
        [dbo].[AccountRole]
    WHERE
        [AccountId] = @AccountId
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AccountRoleSelectByGuid]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[AccountRoleSelectByGuid]
GO

CREATE PROCEDURE [dbo].[AccountRoleSelectByGuid]
(
    @AccountRoleGuid UNIQUEIDENTIFIER
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        [AccountRoleId],
        [AccountRoleGuid],
        [AccountId],
        [RoleName],
        [RoleType],
        [PrivilegeType]
    FROM
        [dbo].[AccountRole]
    WHERE
        [AccountRoleGuid] = @AccountRoleGuid
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AccountRoleSelectById]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[AccountRoleSelectById]
GO

CREATE PROCEDURE [dbo].[AccountRoleSelectById]
(
    @AccountRoleId INT
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        [AccountRoleId],
        [AccountRoleGuid],
        [AccountId],
        [RoleName],
        [RoleType],
        [PrivilegeType]
    FROM
        [dbo].[AccountRole]
    WHERE
        [AccountRoleId] = @AccountRoleId
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AccountRoleSelectIdByAccountIdRoleName]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[AccountRoleSelectIdByAccountIdRoleName]
GO

CREATE PROCEDURE [dbo].[AccountRoleSelectIdByAccountIdRoleName]
(
    @AccountId INT,
    @RoleName NVARCHAR(40),
    @AccountRoleId INT OUT
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        @AccountRoleId = [AccountRoleId]
    FROM
        [dbo].[AccountRole]
    WHERE
        [AccountId] = @AccountId AND
        [RoleName] = @RoleName
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AccountRoleSelectIdByGuid]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[AccountRoleSelectIdByGuid]
GO

CREATE PROCEDURE [dbo].[AccountRoleSelectIdByGuid]
(
    @AccountRoleGuid UNIQUEIDENTIFIER,
    @AccountRoleId INT OUT
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        @AccountRoleId = [AccountRoleId]
    FROM
        [dbo].[AccountRole]
    WHERE
        [AccountRoleGuid] = @AccountRoleGuid
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AccountRoleUpsert]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[AccountRoleUpsert]
GO

CREATE PROCEDURE [dbo].[AccountRoleUpsert]
(
    @AccountRoleGuid UNIQUEIDENTIFIER,
    @AccountId INT,
    @RoleName NVARCHAR(40),
    @RoleType INT,
    @PrivilegeType TINYINT,
    @AccountRoleId INT OUT
)
AS
BEGIN
    SET NOCOUNT ON

    MERGE
        [dbo].[AccountRole] WITH (HOLDLOCK) AS [target]
    USING
        (
            SELECT
                @AccountRoleGuid,
                @AccountId,
                @RoleName,
                @RoleType,
                @PrivilegeType
        )
        AS [source]
        (
            [AccountRoleGuid],
            [AccountId],
            [RoleName],
            [RoleType],
            [PrivilegeType]
        )
    ON
        [target].[AccountRoleGuid] = [source].[AccountRoleGuid]
    WHEN MATCHED THEN
        UPDATE SET
            @AccountRoleId = [target].[AccountRoleId],
            [target].[AccountId] = [source].[AccountId],
            [target].[RoleName] = [source].[RoleName],
            [target].[RoleType] = [source].[RoleType],
            [target].[PrivilegeType] = [source].[PrivilegeType],
            [target].[ModifiedUtc] = SYSUTCDATETIME()
    WHEN NOT MATCHED THEN
        INSERT
        (
            [AccountRoleGuid],
            [AccountId],
            [RoleName],
            [RoleType],
            [PrivilegeType]
        )
        VALUES
        (
            [source].[AccountRoleGuid],
            [source].[AccountId],
            [source].[RoleName],
            [source].[RoleType],
			[source].[PrivilegeType]
        );

    SET @AccountRoleId = ISNULL(@AccountRoleId, SCOPE_IDENTITY())
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[UserDeleteByAccountId]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UserDeleteByAccountId]
GO

CREATE PROCEDURE [dbo].[UserDeleteByAccountId]
(
    @AccountId INT
)
AS
BEGIN
    SET NOCOUNT ON

    DELETE FROM [dbo].[User]
    WHERE [AccountId] = @AccountId
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[UserDeleteById]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UserDeleteById]
GO

CREATE PROCEDURE [dbo].[UserDeleteById]
(
    @UserId INT
)
AS
BEGIN
    SET NOCOUNT ON

    DELETE FROM [dbo].[User]
    WHERE [UserId] = @UserId
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[UserSelectByAccountId]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UserSelectByAccountId]
GO

CREATE PROCEDURE [dbo].[UserSelectByAccountId]
(
    @AccountId INT
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        [UserId],
        [UserGuid],
        [LogonName],
        [AccountId],
        [FirstName],
        [LastName],
        [MiddleName],
        [PasswordSalt],
        [PasswordHash],
        [PasswordChangeUtc],
        [PasswordMustBeChanged],
        [IsLogonEnabled],
        [TimeZone],
        [CultureCode]
    FROM
        [dbo].[User]
    WHERE
        [AccountId] = @AccountId
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[UserSelectByGuid]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UserSelectByGuid]
GO

CREATE PROCEDURE [dbo].[UserSelectByGuid]
(
    @UserGuid UNIQUEIDENTIFIER
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        [UserId],
        [UserGuid],
        [LogonName],
        [AccountId],
        [FirstName],
        [LastName],
        [MiddleName],
        [PasswordSalt],
        [PasswordHash],
        [PasswordChangeUtc],
        [PasswordMustBeChanged],
        [IsLogonEnabled],
        [TimeZone],
        [CultureCode]
    FROM
        [dbo].[User]
    WHERE
        [UserGuid] = @UserGuid
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[UserSelectById]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UserSelectById]
GO

CREATE PROCEDURE [dbo].[UserSelectById]
(
    @UserId INT
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        [UserId],
        [UserGuid],
        [LogonName],
        [AccountId],
        [FirstName],
        [LastName],
        [MiddleName],
        [PasswordSalt],
        [PasswordHash],
        [PasswordChangeUtc],
        [PasswordMustBeChanged],
        [IsLogonEnabled],
        [TimeZone],
        [CultureCode]
    FROM
        [dbo].[User]
    WHERE
        [UserId] = @UserId
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[UserSelectByLogonName]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UserSelectByLogonName]
GO

CREATE PROCEDURE [dbo].[UserSelectByLogonName]
(
    @LogonName NVARCHAR(320)
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        [UserId],
        [UserGuid],
        [LogonName],
        [AccountId],
        [FirstName],
        [LastName],
        [MiddleName],
        [PasswordSalt],
        [PasswordHash],
        [PasswordChangeUtc],
        [PasswordMustBeChanged],
        [IsLogonEnabled],
        [TimeZone],
        [CultureCode]
    FROM
        [dbo].[User]
    WHERE
        [LogonName] = @LogonName
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[UserSelectIdByGuid]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UserSelectIdByGuid]
GO

CREATE PROCEDURE [dbo].[UserSelectIdByGuid]
(
    @UserGuid UNIQUEIDENTIFIER,
    @UserId INT OUT
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        @UserId = [UserId]
    FROM
        [dbo].[User]
    WHERE
        [UserGuid] = @UserGuid
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[UserSelectIdByLogonName]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UserSelectIdByLogonName]
GO

CREATE PROCEDURE [dbo].[UserSelectIdByLogonName]
(
    @LogonName NVARCHAR(320),
    @UserId INT OUT
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        @UserId = [UserId]
    FROM
        [dbo].[User]
    WHERE
        [LogonName] = @LogonName
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[UserUpsert]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UserUpsert]
GO

CREATE PROCEDURE [dbo].[UserUpsert]
(
    @UserGuid UNIQUEIDENTIFIER,
    @LogonName NVARCHAR(320),
    @AccountId INT,
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(100),
    @MiddleName NVARCHAR(30),
    @PasswordSalt NVARCHAR(40),
    @PasswordHash NVARCHAR(40),
    @PasswordChangeUtc DATETIME2(7),
    @PasswordMustBeChanged BIT,
    @IsLogonEnabled BIT,
    @TimeZone INT,
    @CultureCode NVARCHAR(10),
    @UserId INT OUT
)
AS
BEGIN
    SET NOCOUNT ON

    MERGE
        [dbo].[User] WITH (HOLDLOCK) AS [target]
    USING
        (
            SELECT
                @UserGuid,
                @LogonName,
                @AccountId,
                @FirstName,
                @LastName,
                @MiddleName,
                @PasswordSalt,
                @PasswordHash,
                @PasswordChangeUtc,
                @PasswordMustBeChanged,
                @IsLogonEnabled,
                @TimeZone,
                @CultureCode
        )
        AS [source]
        (
            [UserGuid],
            [LogonName],
            [AccountId],
            [FirstName],
            [LastName],
            [MiddleName],
            [PasswordSalt],
            [PasswordHash],
            [PasswordChangeUtc],
            [PasswordMustBeChanged],
            [IsLogonEnabled],
            [TimeZone],
            [CultureCode]
        )
    ON
        [target].[UserGuid] = [source].[UserGuid]
    WHEN MATCHED THEN
        UPDATE SET
            @UserId = [target].[UserId],
            [target].[LogonName] = [source].[LogonName],
            [target].[AccountId] = [source].[AccountId],
            [target].[FirstName] = [source].[FirstName],
            [target].[LastName] = [source].[LastName],
            [target].[MiddleName] = [source].[MiddleName],
            [target].[PasswordSalt] = [source].[PasswordSalt],
            [target].[PasswordHash] = [source].[PasswordHash],
            [target].[PasswordChangeUtc] = [source].[PasswordChangeUtc],
            [target].[PasswordMustBeChanged] = [source].[PasswordMustBeChanged],
            [target].[IsLogonEnabled] = [source].[IsLogonEnabled],
            [target].[TimeZone] = [source].[TimeZone],
            [target].[CultureCode] = [source].[CultureCode],
            [target].[ModifiedUtc] = SYSUTCDATETIME()
    WHEN NOT MATCHED THEN
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
            [PasswordChangeUtc],
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
            [source].[PasswordChangeUtc],
            [source].[PasswordMustBeChanged],
            [source].[IsLogonEnabled],
            [source].[TimeZone],
            [source].[CultureCode]
        );

    SET @UserId = ISNULL(@UserId, SCOPE_IDENTITY())
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[UserRoleDeleteByUserId]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UserRoleDeleteByUserId]
GO

CREATE PROCEDURE [dbo].[UserRoleDeleteByUserId]
(
    @UserId INT
)
AS
BEGIN
    SET NOCOUNT ON

    DELETE FROM [dbo].[UserRole]
    WHERE [UserId] = @UserId
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[UserRoleDeleteByUserIdAccountRoleId]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UserRoleDeleteByUserIdAccountRoleId]
GO

CREATE PROCEDURE [dbo].[UserRoleDeleteByUserIdAccountRoleId]
(
    @UserId INT,
    @AccountRoleId INT
)
AS
BEGIN
    SET NOCOUNT ON

    DELETE FROM [dbo].[UserRole]
    WHERE
        [UserId] = @UserId AND
        [AccountRoleId] = @AccountRoleId
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[UserRoleInsert]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UserRoleInsert]
GO

CREATE PROCEDURE [dbo].[UserRoleInsert]
(
    @UserId INT,
    @AccountRoleId INT
)
AS
BEGIN
    SET NOCOUNT ON

    INSERT INTO [dbo].[UserRole]
    (
        [UserId],
        [AccountRoleId]
    )
    VALUES
    (
        @UserId,
        @AccountRoleId
    )
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[UserRoleSelectByUserId]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UserRoleSelectByUserId]
GO

CREATE PROCEDURE [dbo].[UserRoleSelectByUserId]
(
    @UserId INT
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        [UserId],
        [AccountRoleId]
    FROM
        [dbo].[UserRole]
    WHERE
        [UserId] = @UserId
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[UserRoleSelectByUserIdAccountRoleId]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UserRoleSelectByUserIdAccountRoleId]
GO

CREATE PROCEDURE [dbo].[UserRoleSelectByUserIdAccountRoleId]
(
    @UserId INT,
    @AccountRoleId INT
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        [UserId],
        [AccountRoleId]
    FROM
        [dbo].[UserRole]
    WHERE
        [UserId] = @UserId AND
        [AccountRoleId] = @AccountRoleId
END
GO

IF EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[AccountDeleteById]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[AccountDeleteById]
GO

CREATE PROCEDURE [dbo].[AccountDeleteById]
(
    @AccountId INT
)
AS
BEGIN
    SET NOCOUNT ON

    EXEC [dbo].[UserDeleteByAccountId] @AccountId = @AccountId

    DELETE FROM [dbo].[Account]
    WHERE [AccountId] = @AccountId
END
GO

DECLARE @AddressType TABLE
(
    [AddressTypeId] INT NOT NULL,
    [AddressTypeName] NVARCHAR(100) NOT NULL
)
INSERT INTO @AddressType
VALUES
    (1, 'Billing'),
    (2, 'Physical')
MERGE
    [dbo].[AddressType] WITH (HOLDLOCK) AS [target]
USING
    @AddressType AS [source]
ON
    [target].[AddressTypeId] = [source].[AddressTypeId]
WHEN MATCHED THEN
    UPDATE SET
        [target].[AddressTypeName] = [source].[AddressTypeName],
        [target].[ModifiedUtc] = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN
    DELETE
WHEN NOT MATCHED BY TARGET THEN
    INSERT
    (
        [AddressTypeId],
        [AddressTypeName]
    )
    VALUES
    (
        [source].[AddressTypeId],
        [source].[AddressTypeName]
    );
GO

DECLARE @PrivilegeType TABLE
(
	[PrivilegeTypeId] INT NOT NULL,
	[PrivilegeTypeName] NVARCHAR(100) NOT NULL
)
INSERT INTO @PrivilegeType
VALUES
	(1, 'None'),
	(2, 'View'),
	(3, 'Edit')
MERGE
	[dbo].[PrivilegeType] WITH (HOLDLOCK) AS [target]
USING
	@PrivilegeType AS [source]
ON
	[target].[PrivilegeTypeId] = [source].[PrivilegeTypeId]
WHEN MATCHED THEN
	UPDATE SET
		[target].[PrivilegeTypeName] = [source].[PrivilegeTypeName],
		[target].[ModifiedUtc] = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN
	DELETE
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[PrivilegeTypeId],
		[PrivilegeTypeName]
	)
	VALUES
	(
		[source].[PrivilegeTypeId],
		[source].[PrivilegeTypeName]
	);
GO

DECLARE @RoleType TABLE
(
	[RoleTypeId] INT NOT NULL,
	[RoleTypeName] NVARCHAR(100) NOT NULL
)
INSERT INTO @RoleType
VALUES
	(0x0001,     'APPLICATION_ADMINISTRATOR'),
	(0x0002,     'COMPANY_ADMINISTRATOR'),
	(0x0004,     'COMPANY_USER'),
	(0x0010,     'SYSTEM_ADMINISTRATOR'),
	(0x0020,     'ACCOUNT_ADMINISTRATOR'),
	(0x0040,     'ACCOUNT_SUPPORT'),
	(0x0080,     'NETWORK_MANAGER'),
	(0x00000100, 'SITE_COORDINATOR'),
	(0x00000200, 'SERVICE_SPECIALIST'),
	(0x00002000, 'GUEST')
MERGE
	[dbo].[RoleType] WITH (HOLDLOCK) AS [target]
USING
	@RoleType AS [source]
ON
	[target].[RoleTypeId] = [source].[RoleTypeId]
WHEN MATCHED THEN
	UPDATE SET
		[target].[RoleTypeName] = [source].[RoleTypeName],
		[target].[ModifiedUtc] = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN
	DELETE
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[RoleTypeId],
		[RoleTypeName]
	)
	VALUES
	(
		[source].[RoleTypeId],
		[source].[RoleTypeName]
	);
GO

DECLARE @Account TABLE
(
	[AccountId] INT NOT NULL IDENTITY, 
	[AccountGuid] UNIQUEIDENTIFIER NULL, 
	[AccountNumber] NVARCHAR(8) NOT NULL, 
	[AccountName] NVARCHAR(50) NOT NULL, 
	[IsEnabled] BIT NOT NULL DEFAULT 1, 
	[TimeZone] INT NULL, 
	[PasswordExpirationPeriodInDays] INT NOT NULL, 
	[DataStorageTimeHrs] INT NOT NULL, 
	[NumberOfCodeManagementApps] INT NOT NULL
)
INSERT INTO @Account
VALUES
	(NEWID(), 'Number1', 'Stanislav Account', 1, 2, 3, 60, 1),
	(NEWID(), 'Number2', 'Andrew Account', 1, 2, 3, 60, 1),
	(NEWID(), 'Number3', 'Sergei Account', 1, 2, 3, 60, 1),
	(NEWID(), 'Number4', 'Alexander Account', 1, 2, 3, 60, 1),
	(NEWID(), 'Number5', 'Ivan Account', 1, 2, 3, 60, 1),
	(NEWID(), 'Number6', 'Luda Account', 1, 2, 3, 60, 1),
	(NEWID(), 'Number7', 'Karina Account', 1, 2, 3, 60, 1),
	(NEWID(), 'Number8', 'Lena Account', 1, 2, 3, 60, 1),
	(NEWID(), 'Number9', 'Nastya Account', 1, 2, 3, 60, 1),
	(NEWID(), 'Number10', 'Irina Account', 1, 2, 3, 60, 1)
MERGE
	[dbo].[Account] WITH (HOLDLOCK) AS [target]
USING
	@Account AS [source]
ON
	[target].[AccountId] = [source].[AccountId]
WHEN MATCHED THEN
	UPDATE SET
		[target].[AccountGuid] = [source].[AccountGuid],
		[target].[AccountNumber] = [source].[AccountNumber],
		[target].[AccountName] = [source].[AccountName],
		[target].[IsEnabled] = [source].[IsEnabled],
		[target].[TimeZone] = [source].[TimeZone],
		[target].[PasswordExpirationPeriodInDays] = [source].[PasswordExpirationPeriodInDays],
		[target].[DataStorageTimeHrs] = [source].[DataStorageTimeHrs],
		[target].[NumberOfCodeManagementApps] = [source].[NumberOfCodeManagementApps],
		[target].[CreatedUtc] = SYSUTCDATETIME(),
		[target].[ModifiedUtc] = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN
	DELETE
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[AccountGuid],
		[AccountNumber],
		[AccountName],
		[IsEnabled],
		[TimeZone],
		[PasswordExpirationPeriodInDays],
		[DataStorageTimeHrs],
		[NumberOfCodeManagementApps]
	)
	VALUES
	(
		[source].[AccountGuid],
		[source].[AccountNumber],
		[source].[AccountName],
		[source].[IsEnabled],
		[source].[TimeZone],
		[source].[PasswordExpirationPeriodInDays],
		[source].[DataStorageTimeHrs],
		[source].[NumberOfCodeManagementApps]
	);
GO

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
	(4, 2, null, null, null, 'Kharkiv', 'Ukraine', 'Kharkiv region', null, 'UA'),
	(5, 1, null, null, null, 'Kharkiv', 'Ukraine', 'Kharkiv region', null, 'UA'),
	(6, 2, null, null, null, 'Kharkiv', 'Ukraine', 'Kharkiv region', null, 'UA'),
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

DECLARE @AccountRole TABLE
(
	[AccountRoleId] INT NOT NULL IDENTITY, 
	[AccountRoleGuid] UNIQUEIDENTIFIER NULL, 
	[AccountId] INT NOT NULL, 
	[RoleName] NVARCHAR(40) NOT NULL, 
	[RoleType] INT NOT NULL, 
	[PrivilegeType] TINYINT NOT NULL
)
INSERT INTO @AccountRole
VALUES
	(NEWID(), 1, 'Administrator', 1, 3),
	(NEWID(), 2, 'Administrator', 2, 3),
	(NEWID(), 3, 'User', 4, 3),
	(NEWID(), 4, 'Administrator', 16, 3),
	(NEWID(), 5, 'Administrator', 32, 3),
	(NEWID(), 6, 'Support', 64, 3),
	(NEWID(), 7, 'Manager', 128, 3),
	(NEWID(), 8, 'Coordinator', 256, 3),
	(NEWID(), 9, 'Specialist', 512, 2),
	(NEWID(), 10, 'Guest', 8192, 1)
MERGE
	[dbo].[AccountRole] WITH (HOLDLOCK) AS [target]
USING
	@AccountRole AS [source]
ON
	[target].[AccountRoleId] = [source].[AccountRoleId]
WHEN MATCHED THEN
	UPDATE SET
		[target].[AccountRoleGuid] = [source].[AccountRoleGuid],
		[target].[AccountId] = [source].[AccountId],
		[target].[RoleName] = [source].[RoleName],
		[target].[RoleType] = [source].[RoleType],
		[target].[PrivilegeType] = [source].[PrivilegeType],
		[target].[CreatedUtc] = SYSUTCDATETIME(),
		[target].[ModifiedUtc] = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN
	DELETE
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[AccountRoleGuid],
		[AccountId],
		[RoleName],
		[RoleType],
		[PrivilegeType]
	)
	VALUES
	(
		[source].[AccountRoleGuid],
		[source].[AccountId],
		[source].[RoleName],
		[source].[RoleType],
		[source].[PrivilegeType]
	);
GO

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

DECLARE @UserRole TABLE
(
	[UserId] INT NOT NULL, 
	[AccountRoleId] INT NOT NULL
)
INSERT INTO @UserRole
VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4),
	(5, 5),
	(6, 6),
	(7, 7),
	(8, 8),
	(9, 9),
	(10, 10)
MERGE
	[dbo].[UserRole] WITH (HOLDLOCK) AS [target]
USING
	@UserRole AS [source]
ON
	[target].[UserId] = [source].[UserId] AND 
	[target].[AccountRoleId] = [source].[AccountRoleId]
WHEN MATCHED THEN
	UPDATE SET
		[target].[UserId] = [source].[UserId],
		[target].[AccountRoleId] = [source].[AccountRoleId],
		[target].[CreatedUtc] = SYSUTCDATETIME(),
		[target].[ModifiedUtc] = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN
	DELETE
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[UserId],
		[AccountRoleId]
	)
	VALUES
	(
		[source].[UserId],
		[source].[AccountRoleId]
	);
GO