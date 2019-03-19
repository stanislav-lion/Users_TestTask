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