CREATE PROCEDURE [dbo].[UserSelectIdByLogonName]
(
    @LogonName NVARCHAR(320),
    @UserId INT OUT
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        @UserId = [UserId]
    FROM
        [dbo].[User]
    WHERE
        [LogonName] = @LogonName
END