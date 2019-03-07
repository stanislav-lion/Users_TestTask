CREATE PROCEDURE [dbo].[UserRoleDeleteByUserIdAccountRoleId]
(
    @UserId INT,
    @AccountRoleId INT
)
AS
BEGIN
    SET NOCOUNT ON

    DELETE FROM [dbo].[UserRole]
    WHERE
        [UserId] = @UserId AND
        [AccountRoleId] = @AccountRoleId
END