namespace Users.DataAccess.Database.Repositories.Async
{
    using System;
    using System.Linq;
    using System.Threading.Tasks;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository.Async;

    public class AccountRoleRepositoryAsync : IAccountRoleRepositoryAsync
    {
        public Task<IQueryable<AccountRole>> AccountRolesAsync => throw new NotImplementedException();

        public Task<int> DeleteAsync(int accountRoleId)
        {
            throw new NotImplementedException();
        }

        public Task<int> DeleteByAccountAsync(int accountId)
        {
            throw new NotImplementedException();
        }

        public Task<AccountRole> GetAsync(int accountRoleId)
        {
            throw new NotImplementedException();
        }

        public Task<AccountRole> GetAsync(Guid accountRoleGuid)
        {
            throw new NotImplementedException();
        }

        public Task<AccountRole> GetByAccountAsync(int accountId)
        {
            throw new NotImplementedException();
        }

        public Task<int?> GetIdAsync(Guid accountRoleGuid)
        {
            throw new NotImplementedException();
        }

        public Task<int?> GetIdAsync(int accountId, string roleName)
        {
            throw new NotImplementedException();
        }

        public Task<int> UpsertAsync(AccountRole accountRole)
        {
            throw new NotImplementedException();
        }
    }
}