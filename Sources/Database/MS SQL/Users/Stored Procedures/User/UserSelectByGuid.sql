CREATE PROCEDURE [dbo].[UserSelectByGuid]
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
        [UserGuid] = @UserGuid
END
GO