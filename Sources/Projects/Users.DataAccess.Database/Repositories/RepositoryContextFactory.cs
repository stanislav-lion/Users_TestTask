namespace Users.DataAccess.Database.Repositories
{
    using System;
    using Users.DataAccess.Repository;

    /// <inheritdoc />
    public sealed class RepositoryContextFactory : IRepositoryContextFactory
    {
        private static readonly Lazy<RepositoryContextFactory> Lazy =
            new Lazy<RepositoryContextFactory>(() => new RepositoryContextFactory());

        private RepositoryContextFactory() { }

        /// <summary>
        ///     Gets the instance.
        /// </summary>
        public static RepositoryContextFactory Instance => Lazy.Value;

        /// <inheritdoc />
        public IRepositoryContext CreateRepositoryContext()
        {
            return new RepositoryContext();
        }
    }
}