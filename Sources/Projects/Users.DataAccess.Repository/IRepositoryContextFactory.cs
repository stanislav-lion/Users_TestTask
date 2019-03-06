namespace Users.DataAccess.Repository
{
    /// <summary>
    ///     Repository context factory.
    /// </summary>
    public interface IRepositoryContextFactory
    {
        /// <summary>
        ///     Creates repository context.
        /// </summary>
        /// <returns>Repository context.</returns>
        IRepositoryContext CreateRepositoryContext();
    }
}