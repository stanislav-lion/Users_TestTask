namespace Users.Settings
{
    using Microsoft.EntityFrameworkCore;
    using Users.DataAccess.Database;
    using Users.DataAccess.Database.Contexts;

    public class DBSetting
    {
        public static UserContext GetUserContext(string connectionString)
        {
            return new UserContext(new DbContextOptionsBuilder<UserContext>()
                .UseSqlServer(connectionString)
                .Options);
        }

        public static UserContext GetUserContext(DBMS dbms, string connectionString)
        {
            switch (dbms)
            {
                case DBMS.MSSQL:
                    return new UserContext(new DbContextOptionsBuilder<UserContext>()
                        .UseSqlServer(connectionString)
                        .Options);
                case DBMS.PostgreSQL:
                    return new UserContext(new DbContextOptionsBuilder<UserContext>()
                        .UseNpgsql(connectionString)
                        .Options);
                default:
                    return new UserContext(new DbContextOptionsBuilder<UserContext>()
                        .UseSqlServer(connectionString)
                        .Options);
            }
        }
    }
}