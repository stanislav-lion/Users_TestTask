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
		[AccountGuid] UNIQUEIDENTIFIER NOT NULL, 
		[AccountNumber] NVARCHAR(8) NOT NULL, 
		[AccountName] NVARCHAR(56) NOT NULL, 
		[IsEnabled] BIT NOT NULL, 
		[TimeZone] INT NOT NULL, 
		[PasswordExpirationPeriodInDays] INT NOT NULL, 
		[DataStorageTimeHrs] INT NOT NULL, 
		[NumberOfCodeManagementApps] INT NOT NULL, 
		[NumberOfEMsApps] INT NOT NULL, 
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
		[AddressTypeId] INT NOT NULL, 
		[AddressLine1] NVARCHAR(100) NOT NULL, 
		[AddressLine2] NVARCHAR(100) NOT NULL, 
		[AddressLine3] NVARCHAR(100) NOT NULL, 
		[City] NVARCHAR(100) NOT NULL, 
		[County] NVARCHAR(100) NOT NULL, 
		[StateProvince] NVARCHAR(50) NULL, 
		[PostalCode] NVARCHAR(15) NOT NULL, 
		[CountryTwoLetterCode] NCHAR(2) NOT NULL, 
		[CreatedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
		[ModifiedUtc] DATETIME2(7) NOT NULL DEFAULT SYSUTCDATETIME(), 
		CONSTRAINT [AccountAddress_PK] PRIMARY KEY ([AccountId]),
		CONSTRAINT [AccountAddress_Account_FK] FOREIGN KEY ([AccountId]) REFERENCES [dbo].[Account]([AccountId]) ON DELETE CASCADE, 
		CONSTRAINT [AccountAddress_AddressType_FK] FOREIGN KEY ([AddressTypeId]) REFERENCES [dbo].[AddressType]([AddressTypeId]) ON DELETE CASCADE
	)	
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[RoleType]') AND TYPE IN (N'U'))
BEGIN
	CREATE TABLE [dbo].[RoleType]
	(
		[RoleTypeId] INT NOT NULL , 
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
		[PrivilegeTypeId] TINYINT NOT NULL , 
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
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[User]') AND TYPE IN (N'U'))
BEGIN
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