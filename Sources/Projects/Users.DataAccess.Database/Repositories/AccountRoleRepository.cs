namespace Users.DataAccess.Database.Repositories
{
    using System;
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
            return UserContext.AccountRole
                .FirstOrDefault(accountRole => accountRole.AccountRoleId == accountRoleId);
        }

        /// <inheritdoc />
        public AccountRole Get(Guid accountRoleGuid)
        {
            return UserContext.AccountRole
                .FirstOrDefault(accountRole => accountRole.AccountRoleGuid == accountRoleGuid);
        }

        /// <inheritdoc />
        public AccountRole GetByAccount(int accountId)
        {
            return UserContext.AccountRole
                .FirstOrDefault(accountRole => accountRole.AccountId == accountId);
        }

        /// <inheritdoc />
        public int? GetId(Guid accountRoleGuid)
        {
            AccountRole accountRole = Get(accountRoleGuid);

            if (accountRole == null)
            {
                return null;
            }

            return accountRole.AccountRoleId;
        }

        /// <inheritdoc />
        public int? GetId(
            int accountId,
            string roleName)
        {
            AccountRole accountRole = GetByAccount(accountId, roleName);

            if (accountRole == null)
            {
                return null;
            }

            return accountRole.AccountRoleId;
        }

        /// <inheritdoc />
        public int Upsert(AccountRole accountRole)
        {
            if (Get(accountRole.AccountRoleId) == null)
            {
                UserContext.AccountRole
                    .Add(accountRole);
            }
            else
            {
                UserContext.AccountRole
                    .Update(accountRole);
            }

            return UserContext.SaveChanges();
        }

        /// <inheritdoc />
        public int Delete(int accountRoleId)
        {
            UserContext.AccountRole
                .Remove(Get(accountRoleId));

            return UserContext.SaveChanges();
        }

        /// <inheritdoc />
        public int DeleteByAccount(int accountId)
        {
            UserContext.AccountRole
                .Remove(GetByAccount(accountId));

            return UserContext.SaveChanges();
        }

        private AccountRole GetByAccount(
            int accountId, 
            string roleName)
        {
            return UserContext.AccountRole
                .FirstOrDefault(accountRole => 
                    accountRole.AccountId == accountId && 
                    accountRole.RoleName.Equals(roleName));
        }
    }
}