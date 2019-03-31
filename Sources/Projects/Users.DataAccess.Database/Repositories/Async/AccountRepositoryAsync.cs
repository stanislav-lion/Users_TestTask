namespace Users.DataAccess.Database.Repositories.Async
{
    using System;
    using System.Linq;
    using System.Threading.Tasks;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository.Async;

    public class AccountRepositoryAsync : IAccountRepositoryAsync
    {
        public Task<IQueryable<Account>> AccountsAsync => throw new NotImplementedException();

        public Task<int> DeleteAsync(int accountId)
        {
            throw new NotImplementedException();
        }

        public Task<Account> GetAsync(int accountId)
        {
            throw new NotImplementedException();
        }

        public Task<Account> GetAsync(Guid accountGuid)
        {
            throw new NotImplementedException();
        }

        public Task<int?> GetIdAsync(Guid accountGuid)
        {
            throw new NotImplementedException();
        }

        public Task<int?> GetIdAsync(string accountNumber)
        {
            throw new NotImplementedException();
        }

        public Task<int> UpsertAsync(Account account)
        {
            throw new NotImplementedException();
        }
    }
}