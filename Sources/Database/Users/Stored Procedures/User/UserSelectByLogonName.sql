CREATE PROCEDURE [dbo].[UserSelectByLogonName]
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
        [PasswordSalt],
        [PasswordHash],
        [PasswordChangeUtc],
        [PasswordMustBeChanged],
        [IsLogonEnabled],
        [TimeZone],
        [CultureCode]
    FROM
        [dbo].[User]
    WHERE
        [LogonName] = @LogonName
END