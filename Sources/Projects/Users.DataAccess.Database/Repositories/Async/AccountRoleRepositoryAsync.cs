namespace Users.DataAccess.Database.Repositories.Async
{
    using System;
    using System.Linq;
    using System.Threading.Tasks;
    using Users.DataAccess.Database.BaseRepositories;
    using Users.DataAccess.Database.Contexts;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository.Async;

    /// <inheritdoc cref="IAccountRoleRepositoryAsync" />
    public class AccountRoleRepositoryAsync : UserContextEntityRepository, IAccountRoleRepositoryAsync
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="AccountRoleRepositoryAsync" /> class.
        /// </summary>
        /// <param name="userContext">Database user context.</param>
        public AccountRoleRepositoryAsync(UserContext userContext)
            : base(userContext)
        {

        }

        /// <inheritdoc />
        public Task<IQueryable<AccountRole>> AccountRolesAsync => GetAccountRolesAsync();

        /// <inheritdoc />
        public async Task<AccountRole> GetAsync(int accountRoleId)
        {
            return await Task.Run(
                () =>
                {
                    return UserContext.AccountRole
                        .FirstOrDefault(accountRole => accountRole.AccountRoleId == accountRoleId);
                });
        }

        /// <inheritdoc />
        public async Task<AccountRole> GetAsync(Guid accountRoleGuid)
        {
            return await Task.Run(
                () =>
                {
                    return UserContext.AccountRole
                        .FirstOrDefault(accountRole => accountRole.AccountRoleGuid == accountRoleGuid);
                });
        }

        /// <inheritdoc />
        public async Task<AccountRole> GetByAccountAsync(int accountId)
        {
            return await Task.Run(
                () =>
                {
                    return UserContext.AccountRole
                        .FirstOrDefault(accountRole => accountRole.AccountId == accountId);
                });
        }

        /// <inheritdoc />
        public async Task<int?> GetIdAsync(Guid accountRoleGuid)
        {
            //return await Task.Run(
            //    () =>
            //    {
            //        AccountRole accountRole = GetAsync(accountRoleGuid);

            //        if (accountRole == null)
            //        {
            //            return null;
            //        }

            //        return accountRole.AccountRoleId;
            //    });

            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public async Task<int?> GetIdAsync(
            int accountId,
            string roleName)
        {
            //return await Task.Run(
            //    () =>
            //    {
            //        AccountRole accountRole = GetByAccountAsync(accountId, roleName);

            //        if (accountRole == null)
            //        {
            //            return null;
            //        }

            //        return accountRole.AccountRoleId;
            //    });

            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public async Task<int> UpsertAsync(AccountRole accountRole)
        {
            if (GetAsync(accountRole.AccountRoleId) == null)
            {
                UserContext.AccountRole
                    .Add(accountRole);
            }
            else
            {
                UserContext.AccountRole
                    .Update(accountRole);
            }

            return await UserContext.SaveChangesAsync();
        }

        /// <inheritdoc />
        public async Task<int> DeleteAsync(int accountRoleId)
        {
            UserContext.AccountRole
                .Remove(await GetAsync(accountRoleId));

            return await UserContext.SaveChangesAsync();
        }

        /// <inheritdoc />
        public async Task<int> DeleteByAccountAsync(int accountId)
        {
            UserContext.AccountRole
                .Remove(await GetByAccountAsync(accountId));

            return await UserContext.SaveChangesAsync();
        }

        private async Task<IQueryable<AccountRole>> GetAccountRolesAsync()
        {
            return await Task.Run(
                () =>
                {
                    return UserContext.AccountRole;
                });
        }

        private async Task<AccountRole> GetByAccountAsync(
            int accountId,
            string roleName)
        {
            return await Task.Run(
                () =>
                {
                    return UserContext.AccountRole
                        .FirstOrDefault(accountRole =>
                            accountRole.AccountId == accountId &&
                            accountRole.RoleName.Equals(roleName));
                });
        }
    }
}
}