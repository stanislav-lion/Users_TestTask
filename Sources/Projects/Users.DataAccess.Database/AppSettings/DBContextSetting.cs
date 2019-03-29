namespace Users.DataAccess.Database.AppSettings
{
    public class DBContextSetting
    {
        public int RetriesNumber { get; set; }

        public int SleepBetweenRetriesMilliSeconds { get; set; }

        public int CommandTimeoutSeconds { get; set; }

        public int LongRunningStoredProcedureTimeSeconds { get; set; }
    }
}