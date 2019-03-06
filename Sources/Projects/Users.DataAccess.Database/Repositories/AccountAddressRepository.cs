namespace Users.DataAccess.Database.Repositories
{
    using System;
    using Microsoft.EntityFrameworkCore;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository;

    /// <inheritdoc cref="IAccountAddressRepository" />
    internal sealed class AccountAddressRepository : EntityRepository, IAccountAddressRepository
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="AccountAddressRepository" /> class.
        /// </summary>
        /// <param name="dbContext">Database context.</param>
        public AccountAddressRepository(DbContext dbContext)
            : base(dbContext)
        {

        }

        /// <inheritdoc />
        public AccountAddress Get(int accountId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public void Upsert(AccountAddress accountAddress)
        {
            throw new NotImplementedException();
        }
    }
}