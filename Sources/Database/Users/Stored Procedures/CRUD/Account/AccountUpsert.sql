CREATE PROCEDURE [dbo].[AccountUpsert]
(
    @AccountGuid UNIQUEIDENTIFIER,
    @AccountNumber NVARCHAR(8),
    @AccountName NVARCHAR(56),
    @IsEnabled BIT,
    @TimeZone INT,
    @PasswordExpirationPeriodInDays INT,
    @DataStorageTimeHrs INT,
    @NumberOfCodeManagementApps INT,
    @NumberOfEMsApps INT,
    @AccountId INT OUT
)
AS
BEGIN
    SET NOCOUNT ON

    MERGE
        [dbo].[Account] WITH (HOLDLOCK) AS [target]
    USING
        (
            SELECT
                @AccountGuid,
                @AccountNumber,
                @AccountName,
                @IsEnabled,
                @TimeZone,
                @PasswordExpirationPeriodInDays,
                @DataStorageTimeHrs,
                @NumberOfCodeManagementApps,
                @NumberOfEMsApps
        )
        AS [source]
        (
            [AccountGuid],
            [AccountNumber],
            [AccountName],
            [IsEnabled],
            [TimeZone],
            [PasswordExpirationPeriodInDays],
            [DataStorageTimeHrs],
            [NumberOfCodeManagementApps],
            [NumberOfEMsApps]
        )
    ON
        [target].[AccountGuid] = [source].[AccountGuid]
    WHEN MATCHED THEN
        UPDATE SET
            @AccountId = [target].[AccountId],
            [target].[AccountNumber] = [source].[AccountNumber],
            [target].[AccountName] = [source].[AccountName],
            [target].[IsEnabled] = [source].[IsEnabled],
            [target].[TimeZone] = [source].[TimeZone],
            [target].[PasswordExpirationPeriodInDays] = [source].[PasswordExpirationPeriodInDays],
            [target].[DataStorageTimeHrs] = [source].[DataStorageTimeHrs],
            [target].[NumberOfCodeManagementApps] = [source].[NumberOfCodeManagementApps],
            [target].[NumberOfEMsApps] = [source].[NumberOfEMsApps],
            [target].[ModifiedUtc] = SYSUTCDATETIME()
    WHEN NOT MATCHED THEN
        INSERT
        (
            [AccountGuid],
            [AccountNumber],
            [AccountName],
            [IsEnabled],
            [TimeZone],
            [PasswordExpirationPeriodInDays],
            [DataStorageTimeHrs],
            [NumberOfCodeManagementApps],
            [NumberOfEMsApps]
        )
        VALUES
        (
            [source].[AccountGuid],
            [source].[AccountNumber],
            [source].[AccountName],
            [source].[IsEnabled],
            [source].[TimeZone],
            [source].[PasswordExpirationPeriodInDays],
            [source].[DataStorageTimeHrs],
            [source].[NumberOfCodeManagementApps],
            [source].[NumberOfEMsApps]
        );

    SET @AccountId = ISNULL(@AccountId, SCOPE_IDENTITY())
END