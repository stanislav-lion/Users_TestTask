namespace Users.DataAccess.Database.Repositories.Async
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Users.DataAccess.Database.BaseRepositories;
    using Users.DataAccess.Database.Contexts;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository.Async;

    /// <inheritdoc cref="IUserRepositoryAsync" />
    public class UserRepositoryAsync : UserContextEntityRepository, IUserRepositoryAsync
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="UserRepository" /> class.
        /// </summary>
        /// <param name="userContext">Database user context.</param>
        public UserRepositoryAsync(UserContext userContext)
            : base(userContext)
        {

        }

        /// <inheritdoc />
        public Task<IQueryable<User>> UsersAsync => GetUsers();

        /// <inheritdoc />
        public Task<IQueryable<User>> UsersWithoutPasswordsAsync => GetUsersWithoutPasswords();

        /// <inheritdoc />
        public async Task<User> GetAsync(int userId)
        {
            return await Task.Run(
                () =>
                {
                    return UserContext.User
                        .FirstOrDefault(user => user.UserId == userId);
                });
        }

        /// <inheritdoc />
        public async Task<User> GetAsync(Guid userGuid)
        {
            return await Task.Run(
                () =>
                {
                    return UserContext.User
                        .FirstOrDefault(user => user.UserGuid == userGuid);
                });
        }

        /// <inheritdoc />
        public async Task<User> GetAsync(string logonName)
        {
            return await Task.Run(
                () =>
                {
                    return UserContext.User
                        .FirstOrDefault(user => user.LogonName.Trim().Equals(logonName));
                });
        }

        /// <inheritdoc />
        public async Task<List<User>> GetByAccountAsync(int accountId)
        {
            return await Task.Run(
                () =>
                {
                    return UserContext.User
                        .Where(user => user.AccountId == accountId)
                        .ToList();
                });
        }

        /// <inheritdoc />
        public async Task<int?> GetIdAsync(Guid userGuid)
        {
            User user = await GetAsync(userGuid);

            if (user == null)
            {
                return null;
            }

            return user.UserId;
        }

        /// <inheritdoc />
        public async Task<int?> GetIdAsync(string logonName)
        {
            User user = await GetAsync(logonName);

            if (user == null)
            {
                return null;
            }

            return user.UserId;
        }

        /// <inheritdoc />
        public async Task<int> UpsertAsync(User user)
        {
            if (GetAsync(user.UserId) == null)
            {
                UserContext.User
                    .Add(user);
            }
            else
            {
                UserContext.User
                    .Update(user);
            }

            return await UserContext.SaveChangesAsync();
        }

        /// <inheritdoc />
        public async Task<int> DeleteAsync(int userId)
        {
            UserContext.User
                .Remove(await GetAsync(userId));

            return await UserContext.SaveChangesAsync();
        }

        /// <inheritdoc />
        public async Task<int> DeleteByAccountAsync(int accountId)
        {
            UserContext.User
                .RemoveRange(await GetByAccountAsync(accountId));

            return await UserContext.SaveChangesAsync();
        }

        private async Task<IQueryable<User>> GetUsers()
        {
            return await Task.Run(
                () =>
                {
                    return UserContext.User;
                });
        }

        private async Task<IQueryable<User>> GetUsersWithoutPasswords()
        {
            return await Task.Run(
                () =>
                {
                    return UserContext.User
                        .ToList()
                        .Select(user =>
                        {
                            user.PasswordSalt = null;
                            user.PasswordHash = null;

                            return user;
                        })
                        .AsQueryable();
                });
        }
    }
}