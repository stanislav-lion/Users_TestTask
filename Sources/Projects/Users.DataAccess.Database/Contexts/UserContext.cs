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

        public DbSet<Account> Account { get; set; }

        public DbSet<AccountRole> AccountRole { get; set; }

        public DbSet<AccountAddress> AccountAddress { get; set; }

        public DbSet<User> User { get; set; }

        public DbSet<UserRole> UserRole { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Account>()
                .Property(account => account.AccountNumber)
                .IsRequired()
                .HasMaxLength(8);

            modelBuilder.Entity<Account>()
                .Property(account => account.AccountName)
                .IsRequired()
                .HasMaxLength(50);


            modelBuilder.Entity<AccountRole>()
                .Property(accountRole => accountRole.RoleName)
                .IsRequired()
                .HasMaxLength(40);

            modelBuilder
                .Entity<AccountRole>()
                .Property(accountRole => accountRole.RoleType)
                .HasConversion(
                    value => (int)value,
                    value => (RoleType)value);

            modelBuilder
                .Entity<AccountRole>()
                .Property(accountRole => accountRole.PrivilegeType)
                .HasConversion(
                    value => (byte)value,
                    value => (PrivilegeType)value);


            modelBuilder.Entity<AccountAddress>()
                .HasKey(accountAddress => accountAddress.AccountId);

            modelBuilder
                .Entity<AccountAddress>()
                .Property(accountAddress => accountAddress.AddressType)
                .HasConversion(
                    value => (int)value,
                    value => (AddressType)value);

            modelBuilder.Entity<AccountAddress>()
                .Property(accountAddress => accountAddress.AddressLine1)
                .HasMaxLength(100);

            modelBuilder.Entity<AccountAddress>()
                .Property(accountAddress => accountAddress.AddressLine2)
                .HasMaxLength(100);

            modelBuilder.Entity<AccountAddress>()
                .Property(accountAddress => accountAddress.AddressLine3)
                .HasMaxLength(100);

            modelBuilder.Entity<AccountAddress>()
                .Property(accountAddress => accountAddress.City)
                .IsRequired()
                .HasMaxLength(50);

            modelBuilder.Entity<AccountAddress>()
                .Property(accountAddress => accountAddress.County)
                .IsRequired()
                .HasMaxLength(50);

            modelBuilder.Entity<AccountAddress>()
                .Property(accountAddress => accountAddress.StateProvince)
                .HasMaxLength(50);

            modelBuilder.Entity<AccountAddress>()
                .Property(accountAddress => accountAddress.PostalCode)
                .HasMaxLength(15);

            modelBuilder.Entity<AccountAddress>()
                .Property(accountAddress => accountAddress.CountryTwoLetterCode)
                .IsRequired()
                .HasMaxLength(2);


            modelBuilder.Entity<User>()
                .Property(user => user.LogonName)
                .IsRequired()
                .HasMaxLength(100);

            modelBuilder.Entity<User>()
                .Property(user => user.FirstName)
                .IsRequired()
                .HasMaxLength(50);

            modelBuilder.Entity<User>()
                .Property(user => user.LastName)
                .IsRequired()
                .HasMaxLength(100);

            modelBuilder.Entity<User>()
                .Property(user => user.MiddleName)
                .HasMaxLength(30);

            modelBuilder.Entity<User>()
                .Property(user => user.PasswordSalt)
                .IsRequired()
                .HasMaxLength(30);

            modelBuilder.Entity<User>()
                .Property(user => user.PasswordHash)
                .IsRequired()
                .HasMaxLength(30);

            modelBuilder.Entity<User>()
                .Property(user => user.CultureCode)
                .IsRequired()
                .HasMaxLength(10);


            modelBuilder.Entity<UserRole>()
                .HasKey(userRole => userRole.UserId);
        }
    }
}