namespace Users.TestFramework.Database
{
    using System;
    using System.Collections.Generic;

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
        ///     Valid string.
        /// </summary>
        public const string ValidString = "`";

        /// <summary>
        ///     Gets test date time.
        /// </summary>
        public static DateTime TestDateTime => DateTime.UtcNow;

        /// <summary>
        ///     Invalid string null.
        /// </summary>
        public const string InvalidStringNull = null;

        /// <summary>
        ///     Invalid string comprised of spaces.
        /// </summary>
        public const string InvalidStringSpaces = " ";

        /// <summary>
        ///     Gets invalid string empty.
        /// </summary>
        public static string InvalidStringEmpty => string.Empty;

        /// <summary>
        ///     Gets invalid string long.
        /// </summary>
        public static string InvalidStringLong => new string('`', 8001);

        /// <summary>
        ///     Gets invalid strings.
        /// </summary>
        public static List<object[]> InvalidStrings => new List<object[]>
        {
            new object[]
            {
                InvalidStringNull
            },
            new object[]
            {
                InvalidStringSpaces
            },
            new object[]
            {
                InvalidStringEmpty
            }
        };

        /// <summary>
        ///     Gets invalid and long strings.
        /// </summary>
        public static List<object[]> InvalidAndLongStrings => new List<object[]>(InvalidStrings)
        {
            new object[]
            {
                InvalidStringLong
            }
        };
    }
}