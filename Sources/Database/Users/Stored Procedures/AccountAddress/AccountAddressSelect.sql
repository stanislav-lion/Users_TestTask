CREATE PROCEDURE [dbo].[AccountAddressSelect]
(
    @AccountId INT
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        [AccountId],
        [AddressTypeId],
        [AddressLine1],
        [AddressLine2],
        [AddressLine3],
        [City],
        [County],
        [StateProvince],
        [PostalCode],
        [CountryTwoLetterCode]
    FROM
        [dbo].[AccountAddress]
    WHERE
        [AccountId] = @AccountId
END