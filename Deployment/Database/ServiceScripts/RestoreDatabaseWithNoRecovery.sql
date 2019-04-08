IF NOT EXISTS (SELECT 1 FROM [master].[sys].[databases] WHERE [name] = '$(DatabaseName)')
BEGIN
    RESTORE DATABASE [$(DatabaseName)]
    FROM DISK = '$(BackupFileName)'
    WITH NORECOVERY
END