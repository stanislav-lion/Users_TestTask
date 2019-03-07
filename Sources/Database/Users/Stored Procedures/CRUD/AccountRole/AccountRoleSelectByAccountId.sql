﻿CREATE PROCEDURE [dbo].[AccountRoleSelectByAccountId]
(
    @AccountId INT
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT
        [AccountRoleId],
        [AccountRoleGuid],
        [AccountId],
        [RoleName],
        [RoleTypeId],
        [PrivCodeManagementApp],
        [PrivEMsApp]
    FROM
        [dbo].[AccountRole]
    WHERE
        [AccountId] = @AccountId
END