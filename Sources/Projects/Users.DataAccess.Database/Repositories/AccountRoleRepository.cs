namespace Users.DataAccess.Database.Repositories
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using Users.DataAccess.Database.BaseRepositories;
    using Users.DataAccess.Database.Contexts;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository;

    /// <inheritdoc cref="IAccountRoleRepository" />
    public sealed class AccountRoleRepository : UserContextEntityRepository, IAccountRoleRepository
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="AccountRoleRepository" /> class.
        /// </summary>
        /// <param name="userContext">Database user context.</param>
        public AccountRoleRepository(UserContext userContext)
            : base(userContext)
        {

        }

        /// <inheritdoc />
        public IQueryable<AccountRole> AccountRoles => UserContext.AccountRole;

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