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
                .Entity<AccountAddress>()
                .Property(property => property.AddressType)
                .HasConversion(
                    value => (int) value,
                    value => (AddressType) value);

            modelBuilder
                .Entity<AccountRole>()
                .Property(property => property.PrivilegeType)
                .HasConversion(
                    value => (byte) value,
                    value => (PrivilegeType) value);

            modelBuilder
                .Entity<AccountRole>()
                .Property(property => property.RoleType)
                .HasConversion(
                    value => (int) value,
                    value => (RoleType) value);
        }
    }
}