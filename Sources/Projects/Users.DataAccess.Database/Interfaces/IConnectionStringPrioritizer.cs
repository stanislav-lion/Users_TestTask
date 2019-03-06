namespace Users.DataAccess.Database.Interfaces
{
    /// <summary>
    ///     Connection string prioritizer.
    /// </summary>
    internal interface IConnectionStringPrioritizer
    {
        /// <summary>
        ///     Gets low priority connection string.
        /// </summary>
        /// <param name="connectionString">Connection string.</param>
        /// <returns>Low priority connection string.</returns>
        string GetLowPriorityConnectionString(string connectionString);
    }
}