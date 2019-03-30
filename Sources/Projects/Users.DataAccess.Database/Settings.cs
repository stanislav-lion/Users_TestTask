namespace Users.DataAccess.Database
{
    using Microsoft.Extensions.Configuration;
    using Users.DataAccess.Database.AppSettings;
    using Users.DesignPatterns.Creational;

    public class Settings : LazyInitialization<Settings>
    {
        public Settings()
        {
            var builder = new ConfigurationBuilder();
            builder.AddJsonFile("appSettings.json", optional: false);

            IConfigurationRoot configuration = builder.Build();
        }

        public DBMSSetting DBMSSetting { get; set; }

        public ConnectionString ConnectionString { get; set; }

        public SQLServerConnectionString SQLServerConnectionString { get; set; }

        public PostgreSQLConnectionString PostgreSQLConnectionString { get; set; }

        public DBContextSetting DBContextSetting { get; set; }
    }
}