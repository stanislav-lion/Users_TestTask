namespace Users.DataAccess.Database.Common
{
    using System;
    using System.Collections.Generic;

    /// <summary>
    ///     Retrier helper.
    /// </summary>
    internal static class RetrierHelper
    {
        private static readonly List<int> RetriableErrorNumbers = new List<int>
        {
            // General network error.
            11
        };

        /// <summary>
        ///     Checks if exception is a retriable SQL Server exception.
        /// </summary>
        /// <param name="exception">Exception.</param>
        /// <returns>True if retriable, False otherwise.</returns>
        public static bool IsRetriableSqlError(Exception exception)
        {
            //return exception is SqlException sqlException && RetriableErrorNumbers.Contains(sqlException.Number);
            return false;
        }
    }
}