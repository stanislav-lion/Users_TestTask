CREATE PROCEDURE [dbo].[UserRoleSelectByUserId]
(
    @UserId INT
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
        [UserId] = @UserId
END
GO