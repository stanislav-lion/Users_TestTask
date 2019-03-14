CREATE PROCEDURE [dbo].[UserSelectByAccountIdWithoutPasswords]
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
        [IsLogonEnabled],
        [TimeZone],
        [CultureCode]
    FROM
        [dbo].[User]
    WHERE
        [AccountId] = @AccountId
END
GO