CREATE PROCEDURE [dbo].[AccountDeleteById]
(
    @AccountId INT
)
AS
BEGIN
    SET NOCOUNT ON

    EXEC [dbo].[UserDeleteByAccountId] @AccountId = @AccountId

    DELETE FROM [dbo].[Account]
    WHERE [AccountId] = @AccountId
END