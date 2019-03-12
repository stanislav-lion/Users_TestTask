CREATE PROCEDURE [dbo].[UserSelectByGuidWithoutPasswords]
(
    @UserGuid UNIQUEIDENTIFIER
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        [UserId],
        [UserGuid],
        [LogonName],
        [AccountId],
        [FirstName],
        [LastName],
        [MiddleName],
        [IsLogonEnabled],
        [TimeZone],
        [CultureCode]
    FROM
        [dbo].[User]
    WHERE
        [UserGuid] = @UserGuid
END