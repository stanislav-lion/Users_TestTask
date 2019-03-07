DECLARE @AddressType TABLE
(
    [AddressTypeId] INT NOT NULL,
    [AddressTypeName] NVARCHAR(100) NOT NULL
)

INSERT INTO @AddressType
VALUES
    (1, 'Billing'),
    (2, 'Physical')

MERGE
    [dbo].[AddressType] WITH (HOLDLOCK) AS [target]
USING
    @AddressType AS [source]
ON
    [target].[AddressTypeId] = [source].[AddressTypeId]
WHEN MATCHED THEN
    UPDATE SET
        [target].[AddressTypeName] = [source].[AddressTypeName],
        [target].[ModifiedUtc] = SYSUTCDATETIME()
WHEN NOT MATCHED BY SOURCE THEN
    DELETE
WHEN NOT MATCHED BY TARGET THEN
    INSERT
    (
        [AddressTypeId],
        [AddressTypeName]
    )
    VALUES
    (
        [source].[AddressTypeId],
        [source].[AddressTypeName]
    );
GO