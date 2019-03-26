namespace Users.DataAccess.Repository.Async
{
    /// <summary>
    ///     Repository context factory.
    /// </summary>
    public interface IRepositoryContextFactoryAsync
    {
        /// <summary>
        ///     Creates repository context.
        /// </summary>
        /// <returns>Repository context.</returns>
        IRepositoryContextAsync CreateRepositoryContextAsync();
    }
}