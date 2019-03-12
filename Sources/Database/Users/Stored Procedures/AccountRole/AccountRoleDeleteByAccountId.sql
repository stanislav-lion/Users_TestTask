CREATE PROCEDURE [dbo].[AccountRoleDeleteByAccountId]
(
    @AccountId INT
)
AS
BEGIN
    SET NOCOUNT ON

    DELETE FROM [dbo].[AccountRole]
    WHERE [AccountId] = @AccountId
END