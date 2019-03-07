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
        [RoleTypeId],
        [PrivCodeManagementApp],
        [PrivEMsApp]
    FROM
        [dbo].[AccountRole]
    WHERE
        [AccountRoleId] = @AccountRoleId
END