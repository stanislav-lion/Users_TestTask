namespace Users.CommonSettings
{
    using Microsoft.EntityFrameworkCore;
    using Users.DataAccess.Database.Contexts;

    public class Settings
    {
        public static UserContext GetUserContext()
        {
            return new UserContext(new DbContextOptionsBuilder<UserContext>()
                .UseSqlServer("Data Source=localhost;Initial Catalog=Users;Integrated Security=SSPI")
                //.UseNpgsql("Host=localhost;Database=Users;")
                .Options);
        }
    }
}