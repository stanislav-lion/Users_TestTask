using System.Data.Common;

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
        ///     Checks if exception is a retriable DB exception.
        /// </summary>
        /// <param name="exception">Exception.</param>
        /// <returns>True if retriable, False otherwise.</returns>
        public static bool IsRetriableError(DbException exception)
        {
            //return exception is DbException exception && RetriableErrorNumbers.Contains(exception.Number);
            return false;
        }
    }
}