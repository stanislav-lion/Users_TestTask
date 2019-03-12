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