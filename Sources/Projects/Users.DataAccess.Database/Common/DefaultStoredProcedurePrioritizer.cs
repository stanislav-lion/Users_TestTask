namespace Users.DataAccess.Database.Common
{
    using System.Collections.Generic;
    using System.IO;
    using Users.DataAccess.Database.Interfaces;

    /// <inheritdoc />
    internal sealed class DefaultStoredProcedurePrioritizer : IStoredProcedurePrioritizer
    {
        private const string LowPriorityStoredProceduresFileName = "LowPriorityStoredProcedures.list";
        private static readonly HashSet<string> LowPriorityStoredProcedures = LoadLowPriorityStoredProcedures();

        /// <inheritdoc />
        public bool IsLowPriorityStoredProcedure(string storedProcedureName)
        {
            return LowPriorityStoredProcedures.Contains(storedProcedureName);
        }

        private static HashSet<string> LoadLowPriorityStoredProcedures()
        {
            string[] lines = null;

            if (File.Exists(LowPriorityStoredProceduresFileName))
            {
                lines = File.ReadAllLines(LowPriorityStoredProceduresFileName);
            }

            return (lines != null) 
                ? new HashSet<string>(lines) 
                : new HashSet<string>();
        }
    }
}