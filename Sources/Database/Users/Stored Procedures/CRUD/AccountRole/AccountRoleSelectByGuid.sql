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
        [RoleTypeId],
        [PrivCodeManagementApp],
        [PrivEMsApp]
    FROM
        [dbo].[AccountRole]
    WHERE
        [AccountRoleGuid] = @AccountRoleGuid
END