namespace Users.DataAccess.Database.AppSettings
{
    public class DBMSSetting
    {
        public bool UseMSSQL { get; set; }

        public bool UsePostgreSQL { get; set; }

        public static DBMS GetDBMS(DBMSSetting dbmsSetting)
        {
            if (dbmsSetting.UseMSSQL)
            {
                return DBMS.MSSQL;
            }
            else if (dbmsSetting.UsePostgreSQL)
            {
                return DBMS.PostgreSQL;
            }
            else
            {
                return DBMS.MSSQL;
            }
        }

        public static string GetConnectionString(
            DBMSSetting dbmsSetting,
            ConnectionString connectionString,
            SQLServerConnectionString sqlServerConnectionString,
            PostgreSQLConnectionString postgreSQLConnectionString)
        {
            if (dbmsSetting.UseMSSQL)
            {
                return sqlServerConnectionString.UsersConnectionString;
            }
            else if (dbmsSetting.UsePostgreSQL)
            {
                return postgreSQLConnectionString.UsersConnectionString;
            }
            else
            {
                return connectionString.DefaultConnectionString;
            }
        }
    }
}