CREATE PROCEDURE [dbo].[UserRoleInsert]
(
    @UserId INT,
    @AccountRoleId INT
)
AS
BEGIN
    SET NOCOUNT ON

    INSERT INTO [dbo].[UserRole]
    (
        [UserId],
        [AccountRoleId]
    )
    VALUES
    (
        @UserId,
        @AccountRoleId
    )
END