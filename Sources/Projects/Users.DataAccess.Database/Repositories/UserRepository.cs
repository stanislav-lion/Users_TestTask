namespace Users.DataAccess.Database.Repositories
{
    using System;
    using System.Collections.Generic;
    using Microsoft.EntityFrameworkCore;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository;

    /// <inheritdoc cref="IUserRepository" />
    public sealed class UserRepository : EntityRepository, IUserRepository
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="UserRepository" /> class.
        /// </summary>
        /// <param name="dbContext">Database context.</param>
        public UserRepository(DbContext dbContext)
            : base(dbContext)
        {

        }

        /// <inheritdoc />
        public User Get(int userId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public User Get(Guid userGuid)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public User Get(string logonName)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public List<User> GetByAccount(int accountId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public int? GetId(Guid userGuid)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public void Upsert(User user)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public void Delete(int userId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public void DeleteByAccount(int accountId)
        {
            throw new NotImplementedException();
        }
    }
}