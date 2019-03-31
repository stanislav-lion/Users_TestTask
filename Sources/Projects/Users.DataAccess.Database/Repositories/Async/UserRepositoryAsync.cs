namespace Users.DataAccess.Database.Repositories.Async
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository.Async;

    public class UserRepositoryAsync : IUserRepositoryAsync
    {
        public Task<IQueryable<User>> UsersAsync => throw new NotImplementedException();

        public Task<IQueryable<User>> UsersWithoutPasswordsAsync => throw new NotImplementedException();

        public Task<int> DeleteAsync(int userId)
        {
            throw new NotImplementedException();
        }

        public Task<int> DeleteByAccountAsync(int accountId)
        {
            throw new NotImplementedException();
        }

        public Task<User> GetAsync(int userId)
        {
            throw new NotImplementedException();
        }

        public Task<User> GetAsync(Guid userGuid)
        {
            throw new NotImplementedException();
        }

        public Task<User> GetAsync(string logonName)
        {
            throw new NotImplementedException();
        }

        public Task<List<User>> GetByAccountAsync(int accountId)
        {
            throw new NotImplementedException();
        }

        public Task<int?> GetIdAsync(Guid userGuid)
        {
            throw new NotImplementedException();
        }

        public Task<int?> GetIdAsync(string logonName)
        {
            throw new NotImplementedException();
        }

        public Task<int> UpsertAsync(User user)
        {
            throw new NotImplementedException();
        }
    }
}