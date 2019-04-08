DECLARE @command VARCHAR(MAX) = '' 
SELECT
    @command = @command + 'KILL ' + CAST(session_id AS VARCHAR) + CHAR(13)
FROM
    [sys].[dm_exec_sessions]
WHERE
    DB_NAME([database_id]) = '$(DatabaseName)' AND
    [client_version] IS NOT NULL
IF (@command <> '')
BEGIN    
    EXEC (@command)
END