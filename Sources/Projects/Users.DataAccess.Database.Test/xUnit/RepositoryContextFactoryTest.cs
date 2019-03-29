namespace Users.DataAccess.Database.Test.xUnit
{
    using Users.DataAccess.Database.RepositoryContexts;
    using Xunit;

    /// <summary>
    ///     Tests for the RepositoryContextFactory class.
    /// </summary>
    public class RepositoryContextFactoryTest
    {
        /// <summary>
        ///     OnLongRunningStoredProcedure_EventIsNotRaisedIfStoredProcedureRunsForAShortTime.
        /// </summary>
        [Fact]
        public void OnLongRunningStoredProcedure_EventIsNotRaisedIfStoredProcedureRunsForAShortTime()
        {
            string actualStoredProcedureName = null;
            int actualExecutionTimeSeconds = -1;

            RepositoryContextFactory repositoryContextFactory = RepositoryContextFactory.Instance;

            repositoryContextFactory.OnLongRunningStoredProcedure += (s, e) =>
            {
                actualStoredProcedureName = e.StoredProcedureName;
                actualExecutionTimeSeconds = e.ExecutionTimeSeconds;
            };

            Assert.Null(actualStoredProcedureName);
            Assert.Equal(-1, actualExecutionTimeSeconds);
        }

        /// <summary>
        ///     OnLongRunningStoredProcedure_EventIsRaisedIfStoredProcedureRunsForALongTime.
        /// </summary>
        [Fact]
        public void OnLongRunningStoredProcedure_EventIsRaisedIfStoredProcedureRunsForALongTime()
        {
            const string expectedStoredProcedureName = "LongRunningStoredProcedure";
            int expectedExecutionTimeSeconds = /*Settings.Default.LongRunningStoredProcedureTimeSeconds*/ 5 + 1;
            string actualStoredProcedureName = null;
            int actualExecutionTimeSeconds = -1;

            RepositoryContextFactory repositoryContextFactory = RepositoryContextFactory.Instance;

            repositoryContextFactory.OnLongRunningStoredProcedure += (s, e) =>
            {
                actualStoredProcedureName = e.StoredProcedureName;
                actualExecutionTimeSeconds = e.ExecutionTimeSeconds;
            };

            Assert.NotNull(actualStoredProcedureName);
            Assert.Equal(expectedStoredProcedureName, actualStoredProcedureName);
            Assert.NotEqual(-1, actualExecutionTimeSeconds);
            Assert.True(actualExecutionTimeSeconds >= expectedExecutionTimeSeconds);
        }
    }
}