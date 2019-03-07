CREATE PROCEDURE [dbo].[AccountRoleUpsert]
(
    @AccountRoleGuid UNIQUEIDENTIFIER,
    @AccountId INT,
    @RoleName NVARCHAR(40),
    @RoleTypeId INT,
    @PrivCodeManagementApp TINYINT,
    @PrivEMsApp TINYINT,
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
                @RoleTypeId,
                @PrivCodeManagementApp,
                @PrivEMsApp
        )
        AS [source]
        (
            [AccountRoleGuid],
            [AccountId],
            [RoleName],
            [RoleTypeId],
            [PrivCodeManagementApp],
            [PrivEMsApp]
        )
    ON
        [target].[AccountRoleGuid] = [source].[AccountRoleGuid]
    WHEN MATCHED THEN
        UPDATE SET
            @AccountRoleId = [target].[AccountRoleId],
            [target].[AccountId] = [source].[AccountId],
            [target].[RoleName] = [source].[RoleName],
            [target].[RoleTypeId] = [source].[RoleTypeId],
            [target].[PrivCodeManagementApp] = [source].[PrivCodeManagementApp],
            [target].[PrivEMsApp] = [source].[PrivEMsApp],
            [target].[ModifiedUtc] = SYSUTCDATETIME()
    WHEN NOT MATCHED THEN
        INSERT
        (
            [AccountRoleGuid],
            [AccountId],
            [RoleName],
            [RoleTypeId],
            [PrivCodeManagementApp],
            [PrivEMsApp]
        )
        VALUES
        (
            [source].[AccountRoleGuid],
            [source].[AccountId],
            [source].[RoleName],
            [source].[RoleTypeId],
            [source].[PrivCodeManagementApp],
            [source].[PrivEMsApp]
        );

    SET @AccountRoleId = ISNULL(@AccountRoleId, SCOPE_IDENTITY())
END