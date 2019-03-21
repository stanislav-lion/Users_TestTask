namespace Users.DataAccess.Database.Repositories
{
    using System;
    using System.Linq;
    using Users.DataAccess.Database.BaseRepositories;
    using Users.DataAccess.Database.Contexts;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository;

    /// <inheritdoc cref="IAccountRepository" />
    public sealed class AccountRepository : UserContextEntityRepository, IAccountRepository
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="AccountRepository" /> class.
        /// </summary>
        /// <param name="userContext">Database user context.</param>
        public AccountRepository(UserContext userContext)
            : base(userContext)
        {

        }

        /// <inheritdoc />
        public IQueryable<Account> Accounts => UserContext.Account;

        /// <inheritdoc />
        public Account Get(int accountId)
        {
            return UserContext.Account
                .FirstOrDefault(account => account.AccountId == accountId);
        }

        /// <inheritdoc />
        public Account Get(Guid accountGuid)
        {
            return UserContext.Account
                .FirstOrDefault(account => account.AccountGuid == accountGuid);
        }

        /// <inheritdoc />
        public int? GetId(Guid accountGuid)
        {
            Account account = Get(accountGuid);

            if (account == null)
            {
                return null;
            }

            return account.AccountId;
        }

        /// <inheritdoc />
        public int? GetId(string accountNumber)
        {
            Account account = Get(accountNumber);

            if (account == null)
            {
                return null;
            }

            return account.AccountId;
        }

        /// <inheritdoc />
        public int Upsert(Account account)
        {
            if (Get(account.AccountId) == null)
            {
                UserContext.Account
                    .Add(account);
            }
            else
            {
                UserContext.Account
                    .Update(account);
            }

            return UserContext.SaveChanges();
        }

        /// <inheritdoc />
        public int Delete(int accountId)
        {
            UserContext.Account
                .Remove(Get(accountId));

            return UserContext.SaveChanges();
        }

        private Account Get(string accountNumber)
        {
            return UserContext.Account
                .FirstOrDefault(account => account.AccountNumber == accountNumber);
        }
    }
}