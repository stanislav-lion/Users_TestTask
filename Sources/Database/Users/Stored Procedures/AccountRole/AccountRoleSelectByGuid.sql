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