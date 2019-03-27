namespace Users.TestFramework.Database
{
    using System;

    /// <summary>
    ///     Class containing test values.
    /// </summary>
    public static class TestValues
    {
        /// <summary>
        ///     Test identifier.
        /// </summary>
        public const int TestId = int.MinValue;

        /// <summary>
        ///     Gets test date time.
        /// </summary>
        public static DateTime TestDateTime => DateTime.UtcNow;
    }
}