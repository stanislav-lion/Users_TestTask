namespace Users.DataAccess.Database.RepositoryContexts
{
    using System;
    using Users.DataAccess.DataModel.EventArgs;
    using Users.DataAccess.Repository;

    /// <inheritdoc />
    public sealed class RepositoryContextFactory : IRepositoryContextFactory
    {
        private static readonly Lazy<RepositoryContextFactory> Lazy =
            new Lazy<RepositoryContextFactory>(() => new RepositoryContextFactory());

        private RepositoryContextFactory()
        {

        }

        /// <summary>
        ///     Event that is triggered when stored procedure runs too long.
        /// </summary>
        public event EventHandler<LongRunningStoredProcedureEventArgs> OnLongRunningStoredProcedure;

        /// <summary>
        ///     Gets the instance.
        /// </summary>
        public static RepositoryContextFactory Instance => Lazy.Value;

        /// <inheritdoc />
        public IRepositoryContext CreateRepositoryContext()
        {
            var repositoryContext = new RepositoryContext();

            repositoryContext.OnLongRunningStoredProcedure += (s, e) => OnLongRunningStoredProcedure?.Invoke(
                this,
                new LongRunningStoredProcedureEventArgs(e.StoredProcedureName, e.ExecutionTimeSeconds));

            return repositoryContext;
        }
    }
}