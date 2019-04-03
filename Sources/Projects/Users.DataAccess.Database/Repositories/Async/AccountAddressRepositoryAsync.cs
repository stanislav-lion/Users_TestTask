namespace Users.DataAccess.Database.Repositories.Async
{
    using System.Linq;
    using System.Threading.Tasks;
    using Users.DataAccess.Database.BaseRepositories;
    using Users.DataAccess.Database.Contexts;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository.Async;

    /// <inheritdoc cref="IAccountAddressRepositoryAsync" />
    public class AccountAddressRepositoryAsync : UserContextEntityRepository, IAccountAddressRepositoryAsync
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="AccountAddressRepositoryAsync" /> class.
        /// </summary>
        /// <param name="userContext">Database user context.</param>
        public AccountAddressRepositoryAsync(UserContext userContext)
            : base(userContext)
        {

        }

        /// <inheritdoc />
        public Task<IQueryable<AccountAddress>> AccountAddressesAsync => GetAccountAddressesAsync();

        /// <inheritdoc />
        public async Task<AccountAddress> GetAsync(int accountId)
        {
            return await Task.Run(
                () =>
                {
                    return UserContext.AccountAddress
                        .FirstOrDefault(accountAddress => accountAddress.AccountId == accountId);
                });
        }

        /// <inheritdoc />
        public async Task<int> UpsertAsync(AccountAddress accountAddress)
        {
            if (GetAsync(accountAddress.AccountId) == null)
            {
                UserContext.AccountAddress
                    .Add(accountAddress);
            }
            else
            {
                UserContext.AccountAddress
                    .Update(accountAddress);
            }

            return await UserContext.SaveChangesAsync();
        }

        private async Task<IQueryable<AccountAddress>> GetAccountAddressesAsync()
        {
            return await Task.Run(
                () =>
                {
                    return UserContext.AccountAddress;
                });
        }
    }
}