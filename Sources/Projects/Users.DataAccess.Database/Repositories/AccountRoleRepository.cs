namespace Users.DataAccess.Database.Repositories
{
    using System;
    using System.Collections.Generic;
    using Microsoft.EntityFrameworkCore;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository;

    /// <inheritdoc cref="IAccountRoleRepository" />
    internal sealed class AccountRoleRepository : EntityRepository, IAccountRoleRepository
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="AccountRoleRepository" /> class.
        /// </summary>
        /// <param name="dbContext">Database context.</param>
        public AccountRoleRepository(DbContext dbContext)
            : base(dbContext)
        {

        }

        /// <inheritdoc />
        public AccountRole Get(int accountRoleId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public AccountRole Get(Guid accountRoleGuid)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public List<AccountRole> GetByAccount(int accountId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public int? GetId(Guid accountRoleGuid)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public int? GetId(int accountId, string roleName)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public void Upsert(AccountRole accountRole)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public void Delete(int accountRoleId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public void DeleteByAccount(int accountId)
        {
            throw new NotImplementedException();
        }
    }
}