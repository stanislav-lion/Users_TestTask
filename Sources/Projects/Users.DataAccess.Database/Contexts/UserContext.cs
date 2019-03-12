namespace Users.DataAccess.Database.Contexts
{
    using Microsoft.EntityFrameworkCore;
    using Users.DataAccess.DataModel.Enums;
    using Users.DataAccess.DataModel.Types;

    public class UserContext : DbContext
    {
        public UserContext(DbContextOptions<UserContext> options)
            : base(options)
        {

        }

        public DbSet<User> User { get; set; }

        public DbSet<UserRole> UserRole { get; set; }

        public DbSet<Account> Account { get; set; }

        public DbSet<AccountRole> AccountRole { get; set; }

        public DbSet<AccountAddress> AccountAddress { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder
                .Entity<AccountRole>()
                .Property(p => p.RoleType)
                .HasConversion(
                    x => (int) x, 
                    x => (RoleType) x);

            modelBuilder
                .Entity<AccountRole>()
                .Property(p => p.PrivilegeType)
                .HasConversion(
                    x => (byte)x, 
                    x => (PrivilegeType)x);
        }
    }
}