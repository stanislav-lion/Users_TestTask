CREATE PROCEDURE [dbo].[AccountSelectIdByGuid]
(
    @AccountGuid UNIQUEIDENTIFIER,
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
        [AccountGuid] = @AccountGuid
END
GO