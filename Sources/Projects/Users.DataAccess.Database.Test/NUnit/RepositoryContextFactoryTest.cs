namespace Users.DataAccess.Database.Test.NUnit
{
    using global::NUnit.Framework;
    using Users.DataAccess.Database.RepositoryContexts;

    /// <summary>
    ///     Tests for the RepositoryContextFactory class.
    /// </summary>
    [TestFixture]
    public class RepositoryContextFactoryTest
    {
        /// <summary>
        ///     OnLongRunningStoredProcedure_EventIsNotRaisedIfStoredProcedureRunsForAShortTime.
        /// </summary>
        [Test]
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
            Assert.AreEqual(-1, actualExecutionTimeSeconds);
        }

        /// <summary>
        ///     OnLongRunningStoredProcedure_EventIsRaisedIfStoredProcedureRunsForALongTime.
        /// </summary>
        [Test]
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
            Assert.AreEqual(expectedStoredProcedureName, actualStoredProcedureName);
            Assert.AreNotEqual(-1, actualExecutionTimeSeconds);
            Assert.True(actualExecutionTimeSeconds >= expectedExecutionTimeSeconds);
        }
    }
}