CREATE PROCEDURE [dbo].[UserUpsert]
(
    @UserGuid UNIQUEIDENTIFIER,
    @LogonName NVARCHAR(320),
    @AccountId INT,
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(100),
    @MiddleName NVARCHAR(30),
    @PasswordSalt NVARCHAR(40),
    @PasswordHash NVARCHAR(40),
    @PasswordChangeUtc DATETIME2(7),
    @PasswordMustBeChanged BIT,
    @IsLogonEnabled BIT,
    @TimeZone INT,
    @CultureCode NVARCHAR(10),
    @UserId INT OUT
)
AS
BEGIN
    SET NOCOUNT ON

    MERGE
        [dbo].[User] WITH (HOLDLOCK) AS [target]
    USING
        (
            SELECT
                @UserGuid,
                @LogonName,
                @AccountId,
                @FirstName,
                @LastName,
                @MiddleName,
                @PasswordSalt,
                @PasswordHash,
                @PasswordChangeUtc,
                @PasswordMustBeChanged,
                @IsLogonEnabled,
                @TimeZone,
                @CultureCode
        )
        AS [source]
        (
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
        )
    ON
        [target].[UserGuid] = [source].[UserGuid]
    WHEN MATCHED THEN
        UPDATE SET
            @UserId = [target].[UserId],
            [target].[LogonName] = [source].[LogonName],
            [target].[AccountId] = [source].[AccountId],
            [target].[FirstName] = [source].[FirstName],
            [target].[LastName] = [source].[LastName],
            [target].[MiddleName] = [source].[MiddleName],
            [target].[PasswordSalt] = [source].[PasswordSalt],
            [target].[PasswordHash] = [source].[PasswordHash],
            [target].[PasswordChangeUtc] = [source].[PasswordChangeUtc],
            [target].[PasswordMustBeChanged] = [source].[PasswordMustBeChanged],
            [target].[IsLogonEnabled] = [source].[IsLogonEnabled],
            [target].[TimeZone] = [source].[TimeZone],
            [target].[CultureCode] = [source].[CultureCode],
            [target].[ModifiedUtc] = SYSUTCDATETIME()
    WHEN NOT MATCHED THEN
        INSERT
        (
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
        )
        VALUES
        (
            [source].[UserGuid],
            [source].[LogonName],
            [source].[AccountId],
            [source].[FirstName],
            [source].[LastName],
            [source].[MiddleName],
            [source].[PasswordSalt],
            [source].[PasswordHash],
            [source].[PasswordChangeUtc],
            [source].[PasswordMustBeChanged],
            [source].[IsLogonEnabled],
            [source].[TimeZone],
            [source].[CultureCode]
        );

    SET @UserId = ISNULL(@UserId, SCOPE_IDENTITY())
END