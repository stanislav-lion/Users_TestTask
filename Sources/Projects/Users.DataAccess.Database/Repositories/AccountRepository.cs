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
            : base(userContext) { }

        public IQueryable<Account> Accounts => UserContext.Accounts;

        /// <inheritdoc />
        public Account Get(int accountId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public Account Get(Guid accountGuid)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public int? GetId(Guid accountGuid)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public int? GetId(string accountNumber)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public void Upsert(Account account)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public void Delete(int accountId)
        {
            throw new NotImplementedException();
        }
    }
}