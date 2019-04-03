namespace Users.DataAccess.Database.Repositories.Async
{
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Users.DataAccess.Database.BaseRepositories;
    using Users.DataAccess.Database.Contexts;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository.Async;

    /// <inheritdoc cref="IUserRoleRepositoryAsync" />
    public class UserRoleRepositoryAsync : UserContextEntityRepository, IUserRoleRepositoryAsync
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="UserRoleRepositoryAsync" /> class.
        /// </summary>
        /// <param name="userContext">Database user context.</param>
        public UserRoleRepositoryAsync(UserContext userContext)
            : base(userContext)
        {

        }

        /// <inheritdoc />
        public Task<IQueryable<UserRole>> UserRolesAsync => GetUserRolesAsync();

        /// <inheritdoc />
        public async Task<UserRole> GetAsync(
            int userId,
            int accountRoleId)
        {
            return await Task.Run(
                () =>
                {
                    return UserContext.UserRole
                        .FirstOrDefault(userRole =>
                            userRole.UserId == userId &&
                            userRole.AccountRoleId == accountRoleId);
                });
        }

        /// <inheritdoc />
        public async Task<List<UserRole>> GetAsync(int userId)
        {
            return await Task.Run(
                () =>
                {
                    return UserContext.UserRole
                        .Where(userRole => userRole.UserId == userId)
                        .ToList();
                });
        }

        /// <inheritdoc />
        public async Task<int> AddAsync(UserRole userRole)
        {
            if (GetAsync(userRole.UserId, userRole.AccountRoleId) == null)
            {
                UserContext.UserRole
                    .Add(userRole);

                return await UserContext.SaveChangesAsync();
            }

            return 0;
        }

        /// <inheritdoc />
        public async Task<int> DeleteAsync(int userId)
        {
            UserContext.UserRole
                .RemoveRange(await GetAsync(userId));

            return await UserContext.SaveChangesAsync();
        }

        /// <inheritdoc />
        public async Task<int> DeleteAsync(
            int userId,
            int accountRoleId)
        {
            UserContext.UserRole
                .Remove(await GetAsync(userId, accountRoleId));

            return await UserContext.SaveChangesAsync();
        }

        private async Task<IQueryable<UserRole>> GetUserRolesAsync()
        {
            return await Task.Run(
                () =>
                {
                    return UserContext.UserRole;
                });
        }
    }
}