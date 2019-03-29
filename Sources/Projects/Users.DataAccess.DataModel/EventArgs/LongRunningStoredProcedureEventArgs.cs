namespace Users.DataAccess.DataModel.EventArgs
{
    using System;

    /// <inheritdoc />
    /// <summary>
    ///     Event data for long running stored procedure events.
    /// </summary>
    public class LongRunningStoredProcedureEventArgs : EventArgs
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="LongRunningStoredProcedureEventArgs" /> class.
        /// </summary>
        /// <param name="storedProcedureName">The stored procedure name.</param>
        /// <param name="executionTimeSeconds">The execution time in seconds.</param>
        public LongRunningStoredProcedureEventArgs(
            string storedProcedureName, 
            int executionTimeSeconds)
        {
            if (string.IsNullOrWhiteSpace(storedProcedureName))
            {
                throw new ArgumentNullException(nameof(storedProcedureName));
            }

            StoredProcedureName = storedProcedureName;
            ExecutionTimeSeconds = executionTimeSeconds;
        }

        /// <summary>
        ///     Gets the stored procedure name.
        /// </summary>
        public string StoredProcedureName { get; }

        /// <summary>
        ///     Gets the execution time in seconds.
        /// </summary>
        public int ExecutionTimeSeconds { get; }
    }
}