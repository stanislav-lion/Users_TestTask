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