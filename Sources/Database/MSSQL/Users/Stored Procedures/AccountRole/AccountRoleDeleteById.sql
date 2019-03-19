CREATE PROCEDURE [dbo].[AccountRoleDeleteById]
(
    @AccountRoleId INT
)
AS
BEGIN
    SET NOCOUNT ON

    DELETE FROM [dbo].[AccountRole]
    WHERE [AccountRoleId] = @AccountRoleId
END
GO