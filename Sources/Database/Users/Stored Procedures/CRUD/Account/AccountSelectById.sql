CREATE PROCEDURE [dbo].[AccountSelectById]
(
    @AccountId INT
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        [AccountId],
        [AccountGuid],
        [AccountNumber],
        [AccountName],
        [IsEnabled],
        [TimeZone],
        [PasswordExpirationPeriodInDays],
        [DataStorageTimeHrs],
        [NumberOfCodeManagementApps],
        [NumberOfEMsApps]
    FROM
        [dbo].[Account]
    WHERE
        [AccountId] = @AccountId
END