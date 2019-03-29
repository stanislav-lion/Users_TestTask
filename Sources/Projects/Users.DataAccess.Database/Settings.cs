namespace Users.DataAccess.Database
{
    using Users.DataAccess.Database.AppSettings;

    public class Settings
    {
        public static DBMSSetting DBMSSetting { get; set; }

        public static ConnectionString ConnectionString { get; set; }

        public static SQLServerConnectionString SQLServerConnectionString { get; set; }

        public static PostgreSQLConnectionString PostgreSQLConnectionString { get; set; }

        public static DBContextSetting DBContextSetting { get; set; }
    }
}