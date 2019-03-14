CREATE PROCEDURE [dbo].[UserSelectIdByGuid]
(
    @UserGuid UNIQUEIDENTIFIER,
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
        [UserGuid] = @UserGuid
END
GO