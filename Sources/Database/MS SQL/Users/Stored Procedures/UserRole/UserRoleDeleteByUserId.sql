CREATE PROCEDURE [dbo].[UserRoleDeleteByUserId]
(
    @UserId INT
)
AS
BEGIN
    SET NOCOUNT ON

    DELETE FROM [dbo].[UserRole]
    WHERE [UserId] = @UserId
END
GO