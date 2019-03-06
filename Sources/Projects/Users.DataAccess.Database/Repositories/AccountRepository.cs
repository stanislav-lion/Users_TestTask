namespace Users.DataAccess.Database.Repositories
{
    using System;
    using Microsoft.EntityFrameworkCore;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository;

    /// <inheritdoc cref="IAccountRepository" />
    internal sealed class AccountRepository : EntityRepository, IAccountRepository
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="AccountRepository" /> class.
        /// </summary>
        /// <param name="dbContext">Database context.</param>
        public AccountRepository(DbContext dbContext)
            : base(dbContext)
        {

        }

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