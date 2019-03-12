CREATE PROCEDURE [dbo].[UserSelectByLogonNameWithoutPasswords]
(
    @LogonName NVARCHAR(320)
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
        [LogonName] = @LogonName
END