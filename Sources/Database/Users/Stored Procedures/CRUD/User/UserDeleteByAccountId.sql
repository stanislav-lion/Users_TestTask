CREATE PROCEDURE [dbo].[UserDeleteByAccountId]
(
    @AccountId INT
)
AS
BEGIN
    SET NOCOUNT ON

    DELETE FROM [dbo].[User]
    WHERE [AccountId] = @AccountId
END