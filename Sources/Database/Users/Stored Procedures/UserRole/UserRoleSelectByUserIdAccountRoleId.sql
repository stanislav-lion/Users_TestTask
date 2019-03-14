CREATE PROCEDURE [dbo].[UserRoleSelectByUserIdAccountRoleId]
(
    @UserId INT,
    @AccountRoleId INT
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        [UserId],
        [AccountRoleId]
    FROM
        [dbo].[UserRole]
    WHERE
        [UserId] = @UserId AND
        [AccountRoleId] = @AccountRoleId
END
GO