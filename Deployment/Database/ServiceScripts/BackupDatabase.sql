DECLARE @IsDatabaseBackedUp BIT = 0
IF EXISTS (SELECT 1 FROM [master].[sys].[databases] WHERE [name] = '$(DatabaseName)')
BEGIN
    BACKUP DATABASE [$(DatabaseName)]
    TO DISK = '$(BackupFileName)'
    WITH INIT

    SET @IsDatabaseBackedUp = 1
END
SELECT @IsDatabaseBackedUp AS [IsDatabaseBackedUp]