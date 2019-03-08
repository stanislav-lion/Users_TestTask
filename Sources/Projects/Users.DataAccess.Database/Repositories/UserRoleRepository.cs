namespace Users.DataAccess.Database.Repositories
{
    using System;
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
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public List<UserRole> Get(int userId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public void Add(UserRole userRole)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public void Delete(int userId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public void Delete(int userId, int accountRoleId)
        {
            throw new NotImplementedException();
        }
    }
}