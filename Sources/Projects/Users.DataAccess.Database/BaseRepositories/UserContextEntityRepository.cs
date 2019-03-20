namespace Users.DataAccess.Database.BaseRepositories
{
    using System;
    using Users.DataAccess.Database.Contexts;

    /// <summary>
    ///     Base class for repository of user context.
    /// </summary>
    public abstract class UserContextEntityRepository : EntityRepository
    {
        private readonly UserContext _userContext;

        /// <summary>
        ///     Initializes a new instance of the <see cref="UserContextEntityRepository" /> class.
        /// </summary>
        /// <param name="dbContext">Database user context.</param>
        protected UserContextEntityRepository(UserContext userContext)
            : base(userContext)
        {
            _userContext = userContext ?? throw new ArgumentNullException(nameof(userContext));
        }

        /// <summary>
        ///     Gets database user context.
        /// </summary>
        protected UserContext UserContext => _userContext;

        /// <summary>
        ///     Gets type of database user context.
        /// </summary>
        protected Type TypeUserContext => _userContext.GetType();
    }
}