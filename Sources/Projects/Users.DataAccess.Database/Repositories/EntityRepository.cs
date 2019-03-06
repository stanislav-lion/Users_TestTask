namespace Users.DataAccess.Database.Repositories
{
    using System;
    using Microsoft.EntityFrameworkCore;

    /// <summary>
    ///     Base class for repository.
    /// </summary>
    public abstract class EntityRepository
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="EntityRepository" /> class.
        /// </summary>
        /// <param name="dbContext">Database context.</param>
        protected EntityRepository(DbContext dbContext)
        {
            DbContext = dbContext ?? throw new ArgumentNullException(nameof(dbContext));
        }

        /// <summary>
        ///     Gets database context.
        /// </summary>
        protected DbContext DbContext { get; }
    }
}