namespace Users.DataAccess.Database.Interfaces
{
    /// <summary>
    ///     Stored procedure prioritizer.
    /// </summary>
    internal interface IStoredProcedurePrioritizer
    {
        /// <summary>
        ///     Checks if stored procedure has a low priority.
        /// </summary>
        /// <param name="storedProcedureName">Stored procedure name.</param>
        /// <returns>True if low priority, False otherwise.</returns>
        bool IsLowPriorityStoredProcedure(string storedProcedureName);
    }
}