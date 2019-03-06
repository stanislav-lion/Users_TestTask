namespace Users.DataAccess.Database.Contexts
{
    using Microsoft.EntityFrameworkCore;
    using Users.DataAccess.DataModel.Types;

    public class UserContext : DbContext
    {
        public DbSet<User> Users { get; set; }

        public DbSet<UserRole> UserRoles { get; set; }

        public DbSet<Account> Accounts { get; set; }

        public DbSet<AccountRole> AccountRoles { get; set; }

        public DbSet<AccountAddress> AccountAddresses { get; set; }
    }
}