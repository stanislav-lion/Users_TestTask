namespace Users.DataAccess.Database.Repositories
{
    using System.Linq;
    using Users.DataAccess.Database.BaseRepositories;
    using Users.DataAccess.Database.Contexts;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository;

    /// <inheritdoc cref="IAccountAddressRepository" />
    public sealed class AccountAddressRepository : UserContextEntityRepository, IAccountAddressRepository
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="AccountAddressRepository" /> class.
        /// </summary>
        /// <param name="userContext">Database user context.</param>
        public AccountAddressRepository(UserContext userContext)
            : base(userContext)
        {

        }

        /// <inheritdoc />
        public IQueryable<AccountAddress> AccountAddresses => UserContext.AccountAddress;

        /// <inheritdoc />
        public AccountAddress Get(int accountId)
        {
            return UserContext.AccountAddress
                .FirstOrDefault(accountAddress => accountAddress.AccountId == accountId);
        }

        /// <inheritdoc />
        public int Upsert(AccountAddress accountAddress)
        {
            if (Get(accountAddress.AccountId) == null)
            {
                UserContext.AccountAddress
                    .Add(accountAddress);
            }
            else
            {
                UserContext.AccountAddress
                    .Update(accountAddress);
            }

            return UserContext.SaveChanges();
        }
    }
}