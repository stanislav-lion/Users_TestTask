CREATE PROCEDURE [dbo].[AccountAddressUpsert]
(
    @AccountId INT,
    @AddressType INT,
    @AddressLine1 NVARCHAR(100),
    @AddressLine2 NVARCHAR(100),
    @AddressLine3 NVARCHAR(100),
    @City NVARCHAR(100),
    @County NVARCHAR(100),
    @StateProvince NVARCHAR(50) = NULL,
    @PostalCode NVARCHAR(15),
    @CountryTwoLetterCode NCHAR(2)
)
AS
BEGIN
    SET NOCOUNT ON

    MERGE
        [dbo].[AccountAddress] WITH (HOLDLOCK) AS [target]
    USING
        (
            SELECT
                @AccountId,
                @AddressType,
                @AddressLine1,
                @AddressLine2,
                @AddressLine3,
                @City,
                @County,
                @StateProvince,
                @PostalCode,
                @CountryTwoLetterCode
        )
        AS [source]
        (
            [AccountId],
            [AddressType],
            [AddressLine1],
            [AddressLine2],
            [AddressLine3],
            [City],
            [County],
            [StateProvince],
            [PostalCode],
            [CountryTwoLetterCode]
        )
    ON
        [target].[AccountId] = [source].[AccountId]
    WHEN MATCHED THEN
        UPDATE SET
            [target].[AddressType] = [source].[AddressType],
            [target].[AddressLine1] = [source].[AddressLine1],
            [target].[AddressLine2] = [source].[AddressLine2],
            [target].[AddressLine3] = [source].[AddressLine3],
            [target].[City] = [source].[City],
            [target].[County] = [source].[County],
            [target].[StateProvince] = [source].[StateProvince],
            [target].[PostalCode] = [source].[PostalCode],
            [target].[CountryTwoLetterCode] = [source].[CountryTwoLetterCode],
            [target].[ModifiedUtc] = SYSUTCDATETIME()
    WHEN NOT MATCHED THEN
        INSERT
        (
            [AccountId],
            [AddressType],
            [AddressLine1],
            [AddressLine2],
            [AddressLine3],
            [City],
            [County],
            [StateProvince],
            [PostalCode],
            [CountryTwoLetterCode]
        )
        VALUES
        (
            [source].[AccountId],
            [source].[AddressType],
            [source].[AddressLine1],
            [source].[AddressLine2],
            [source].[AddressLine3],
            [source].[City],
            [source].[County],
            [source].[StateProvince],
            [source].[PostalCode],
            [source].[CountryTwoLetterCode]
        );
END
GO