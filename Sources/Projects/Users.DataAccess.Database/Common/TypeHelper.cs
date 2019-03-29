namespace Users.DataAccess.Database.Common
{
    using System;

    /// <summary>
    ///     Type helper.
    /// </summary>
    internal static class TypeHelper
    {
        /// <summary>
        ///     Sets the datetime kind of the DateTime object to Utc.
        /// </summary>
        /// <param name="dateTime">The DateTime object.</param>
        /// <returns>The DateTime object with the datetime kind set to Utc.</returns>
        public static DateTime ToKindUtc(this DateTime dateTime)
        {
            return DateTime.SpecifyKind(dateTime, DateTimeKind.Utc);
        }
    }
}