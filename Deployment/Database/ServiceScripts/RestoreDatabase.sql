RESTORE DATABASE [$(DatabaseName)]
FROM DISK = '$(BackupFileName)'
WITH REPLACE