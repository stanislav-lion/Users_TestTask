namespace Users.Settings
{
    using Microsoft.EntityFrameworkCore;
    using Users.DataAccess.Database.Contexts;

    public class DBSetting
    {
        public static UserContext GetUserContext(string connectionString)
        {
            return new UserContext(new DbContextOptionsBuilder<UserContext>()
                .UseSqlServer(connectionString)
                //.UseNpgsql(connectionString)
                .Options);
        }
    }
}