IF (EXISTS (SELECT 1 FROM [sys].[databases] WHERE [name] = '$(DatabaseName)' AND [replica_id] IS NOT NULL))
BEGIN
    ALTER DATABASE [$(DatabaseName)] SET HADR OFF
END