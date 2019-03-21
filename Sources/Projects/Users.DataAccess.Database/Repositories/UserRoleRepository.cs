namespace Users.DataAccess.Database.Repositories
{
    using System.Collections.Generic;
    using System.Linq;
    using Users.DataAccess.Database.BaseRepositories;
    using Users.DataAccess.Database.Contexts;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository;

    /// <inheritdoc cref="IUserRoleRepository" />
    public sealed class UserRoleRepository : UserContextEntityRepository, IUserRoleRepository
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="UserRoleRepository" /> class.
        /// </summary>
        /// <param name="userContext">Database user context.</param>
        public UserRoleRepository(UserContext userContext)
            : base(userContext)
        {

        }

        /// <inheritdoc />
        public IQueryable<UserRole> UserRoles => UserContext.UserRole;

        /// <inheritdoc />
        public UserRole Get(int userId, int accountRoleId)
        {
            return UserContext.UserRole
                .FirstOrDefault(userRole => 
                    userRole.UserId == userId && 
                    userRole.AccountRoleId == accountRoleId);
        }

        /// <inheritdoc />
        public List<UserRole> Get(int userId)
        {
            return UserContext.UserRole
                .Where(userRole => userRole.UserId == userId)
                .ToList();
        }

        /// <inheritdoc />
        public int Add(UserRole userRole)
        {
            if (Get(userRole.UserId, userRole.AccountRoleId) == null)
            {
                UserContext.UserRole
                    .Add(userRole);

                return UserContext.SaveChanges();
            }

            return 0;
        }

        /// <inheritdoc />
        public int Delete(int userId)
        {
            UserContext.UserRole
                .RemoveRange(Get(userId));

            return UserContext.SaveChanges();
        }

        /// <inheritdoc />
        public int Delete(int userId, int accountRoleId)
        {
            UserContext.UserRole
                .Remove(Get(userId, accountRoleId));

            return UserContext.SaveChanges();
        }
    }
}