namespace Users.Extensions
{
    using System.Linq;

    public static class StringExtensions
    {
        public static string FirstCharToUpper(this string input)
        {
            return (string.IsNullOrEmpty(input))
                ? string.Empty
                : input.First().ToString().ToUpper() + input.Substring(1);
        }

        public static string FirstCharToLower(this string input)
        {
            return (string.IsNullOrEmpty(input))
                ? string.Empty
                : input.First().ToString().ToLower() + input.Substring(1);
        }
    }
}