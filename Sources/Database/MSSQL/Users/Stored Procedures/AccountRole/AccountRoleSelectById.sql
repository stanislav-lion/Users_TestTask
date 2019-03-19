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