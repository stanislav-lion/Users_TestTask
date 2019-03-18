CREATE PROCEDURE [dbo].[UserSelectByAccountId]
(
    @AccountId INT
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
        [AccountId] = @AccountId
END
GO