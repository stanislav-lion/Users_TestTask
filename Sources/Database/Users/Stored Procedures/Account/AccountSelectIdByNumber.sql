CREATE PROCEDURE [dbo].[AccountSelectIdByNumber]
(
    @AccountNumber NVARCHAR(8),
    @AccountId INT OUT
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        @AccountId = [AccountId]
    FROM
        [dbo].[Account]
    WHERE
        [AccountNumber] = @AccountNumber
END
GO