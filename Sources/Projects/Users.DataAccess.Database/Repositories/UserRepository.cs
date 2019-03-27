namespace Users.DataAccess.Database.Repositories
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using Users.DataAccess.Database.BaseRepositories;
    using Users.DataAccess.Database.Contexts;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository;

    /// <inheritdoc cref="IUserRepository" />
    public sealed class UserRepository : UserContextEntityRepository, IUserRepository
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="UserRepository" /> class.
        /// </summary>
        /// <param name="userContext">Database user context.</param>
        public UserRepository(UserContext userContext)
            : base(userContext)
        {
            
        }

        /// <inheritdoc />
        public IQueryable<User> Users => UserContext.User;

        /// <inheritdoc />
        public IQueryable<User> UsersWithoutPasswords => GetUsersWithoutPasswords();

        /// <inheritdoc />
        public User Get(int userId)
        {
            return UserContext.User
                .FirstOrDefault(user => user.UserId == userId);
        }

        /// <inheritdoc />
        public User Get(Guid userGuid)
        {
            return UserContext.User
                .FirstOrDefault(user => user.UserGuid == userGuid);
        }

        /// <inheritdoc />
        public User Get(string logonName)
        {
            return UserContext.User
                .FirstOrDefault(user => user.LogonName.Trim().Equals(logonName));
        }

        /// <inheritdoc />
        public List<User> GetByAccount(int accountId)
        {
            return UserContext.User
                .Where(user => user.AccountId == accountId)
                .ToList();
        }

        /// <inheritdoc />
        public int? GetId(Guid userGuid)
        {
            User user = Get(userGuid);

            if (user == null)
            {
                return null;
            }

            return user.UserId;
        }

        /// <inheritdoc />
        public int? GetId(string logonName)
        {
            User user = Get(logonName);

            if (user == null)
            {
                return null;
            }

            return user.UserId;
        }

        /// <inheritdoc />
        public int Upsert(User user)
        {
            if (Get(user.UserId) == null)
            {
                UserContext.User
                    .Add(user);
            }
            else
            {
                UserContext.User
                    .Update(user);
            }

            return UserContext.SaveChanges();
        }

        /// <inheritdoc />
        public int Delete(int userId)
        {
            UserContext.User
                .Remove(Get(userId));

            return UserContext.SaveChanges();
        }

        /// <inheritdoc />
        public int DeleteByAccount(int accountId)
        {
            UserContext.User
                .RemoveRange(GetByAccount(accountId));

            return UserContext.SaveChanges();
        }

        private IQueryable<User> GetUsersWithoutPasswords()
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
        }
    }
}