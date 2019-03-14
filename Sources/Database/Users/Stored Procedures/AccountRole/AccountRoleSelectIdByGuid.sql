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