CREATE PROCEDURE [dbo].[AccountSelectByGuid]
(
    @AccountGuid UNIQUEIDENTIFIER
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
        [NumberOfCodeManagementApps]
    FROM
        [dbo].[Account]
    WHERE
        [AccountGuid] = @AccountGuid
END