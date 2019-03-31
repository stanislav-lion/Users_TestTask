namespace Users.DataAccess.Database.Repositories.Async
{
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository.Async;

    public class UserRoleRepositoryAsync : IUserRoleRepositoryAsync
    {
        public Task<IQueryable<UserRole>> UserRolesAsync => throw new System.NotImplementedException();

        public Task<int> AddAsync(UserRole userRole)
        {
            throw new System.NotImplementedException();
        }

        public Task<int> DeleteAsync(int userId)
        {
            throw new System.NotImplementedException();
        }

        public Task<int> DeleteAsync(int userId, int accountRoleId)
        {
            throw new System.NotImplementedException();
        }

        public Task<UserRole> GetAsync(int userId, int accountRoleId)
        {
            throw new System.NotImplementedException();
        }

        public Task<List<UserRole>> GetAsync(int userId)
        {
            throw new System.NotImplementedException();
        }
    }
}