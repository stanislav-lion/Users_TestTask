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