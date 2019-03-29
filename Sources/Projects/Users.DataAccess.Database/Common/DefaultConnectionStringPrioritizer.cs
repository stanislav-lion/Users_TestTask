namespace Users.DataAccess.Database.Common
{
    using System.Data.Common;
    using Users.DataAccess.Database.Interfaces;

    /// <inheritdoc />
    internal sealed class DefaultConnectionStringPrioritizer : IConnectionStringPrioritizer
    {
        private const string LowPriorityApplicationName = "ABLow";

        /// <inheritdoc />
        public string GetLowPriorityConnectionString(string connectionString)
        {
            var connectionStringBuilder = new DbConnectionStringBuilder()
            {
                ConnectionString = connectionString,
            };

            connectionStringBuilder.Add("ApplicationName", LowPriorityApplicationName);

            return connectionStringBuilder.ConnectionString;
        }
    }
}