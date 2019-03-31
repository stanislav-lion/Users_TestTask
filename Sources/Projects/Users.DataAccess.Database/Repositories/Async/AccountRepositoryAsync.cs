namespace Users.DataAccess.Database.Repositories.Async
{
    using System.Linq;
    using System.Threading.Tasks;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository.Async;

    public class AccountRepositoryAsync : IAccountAddressRepositoryAsync
    {
        public Task<IQueryable<AccountAddress>> AccountAddressesAsync => throw new System.NotImplementedException();

        public Task<AccountAddress> GetAsync(int accountId)
        {
            throw new System.NotImplementedException();
        }

        public Task<int> UpsertAsync(AccountAddress accountAddress)
        {
            throw new System.NotImplementedException();
        }
    }
}