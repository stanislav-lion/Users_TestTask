namespace Users.DataAccess.Database.Repositories.Async
{
    using System;
    using System.Linq;
    using System.Threading.Tasks;
    using Users.DataAccess.Database.BaseRepositories;
    using Users.DataAccess.Database.Contexts;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository.Async;

    /// <inheritdoc cref="IAccountRepositoryAsync" />
    public class AccountRepositoryAsync : UserContextEntityRepository, IAccountRepositoryAsync
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="AccountRepositoryAsync" /> class.
        /// </summary>
        /// <param name="userContext">Database user context.</param>
        public AccountRepositoryAsync(UserContext userContext)
            : base(userContext)
        {

        }

        /// <inheritdoc />
        public Task<IQueryable<Account>> AccountsAsync => GetAccountsAsync();

        /// <inheritdoc />
        public async Task<Account> GetAsync(int accountId)
        {
            return await Task.Run(
                () =>
                {
                    return UserContext.Account
                        .FirstOrDefault(account => account.AccountId == accountId);
                });
        }

        /// <inheritdoc />
        public async Task<Account> GetAsync(Guid accountGuid)
        {
            return await Task.Run(
                () =>
                {
                    return UserContext.Account
                        .FirstOrDefault(account => account.AccountGuid == accountGuid);
                });
        }

        /// <inheritdoc />
        public async Task<int?> GetIdAsync(Guid accountGuid)
        {
            Account account = await GetAsync(accountGuid);

            if (account == null)
            {
                return null;
            }

            return account.AccountId;
        }

        /// <inheritdoc />
        public async Task<int?> GetIdAsync(string accountNumber)
        {
            Account account = await GetAsync(accountNumber);

            if (account == null)
            {
                return null;
            }

            return account.AccountId;
        }

        /// <inheritdoc />
        public async Task<int> UpsertAsync(Account account)
        {
            if (GetAsync(account.AccountId) == null)
            {
                UserContext.Account
                    .Add(account);
            }
            else
            {
                UserContext.Account
                    .Update(account);
            }

            return await UserContext.SaveChangesAsync();
        }

        /// <inheritdoc />
        public async Task<int> DeleteAsync(int accountId)
        {
            UserContext.Account
                .Remove(await GetAsync(accountId));

            return await UserContext.SaveChangesAsync();
        }

        private async Task<IQueryable<Account>> GetAccountsAsync()
        {
            return await Task.Run(
                () =>
                {
                    return UserContext.Account;
                });
        }

        private async Task<Account> GetAsync(string accountNumber)
        {
            return await Task.Run(
                () =>
                {
                    return UserContext.Account
                        .FirstOrDefault(account => account.AccountNumber == accountNumber);
                });
        }
    }
}