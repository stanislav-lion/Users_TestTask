namespace Users.DataAccess.Database.Repositories
{
    using System;
    using System.Collections.Generic;
    using Microsoft.EntityFrameworkCore;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository;

    /// <inheritdoc cref="IUserRoleRepository" />
    internal sealed class UserRoleRepository : EntityRepository, IUserRoleRepository
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="UserRoleRepository" /> class.
        /// </summary>
        /// <param name="dbContext">Database context.</param>
        public UserRoleRepository(DbContext dbContext)
            : base(dbContext)
        {

        }

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