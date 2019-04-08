IF EXISTS (SELECT 1 FROM [sys].[databases] WHERE [name] = '$(DatabaseName)')
BEGIN
    DROP DATABASE [$(DatabaseName)]
END