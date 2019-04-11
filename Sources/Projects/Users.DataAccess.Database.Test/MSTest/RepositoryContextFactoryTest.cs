namespace Users.DataAccess.Database.Test.MSTest
{
    using Microsoft.VisualStudio.TestTools.UnitTesting;
    using Users.DataAccess.Database.RepositoryContexts;

    /// <summary>
    ///     Tests for the RepositoryContextFactory class.
    /// </summary>
    [TestClass]
    public class RepositoryContextFactoryTest
    {
        /// <summary>
        ///     OnLongRunningStoredProcedure_EventIsNotRaisedIfStoredProcedureRunsForAShortTime.
        /// </summary>
        [TestMethod]
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

            Assert.IsNull(actualStoredProcedureName);
            Assert.AreEqual(-1, actualExecutionTimeSeconds);
        }

        /// <summary>
        ///     OnLongRunningStoredProcedure_EventIsRaisedIfStoredProcedureRunsForALongTime.
        /// </summary>
        [TestMethod]
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

            Assert.IsNotNull(actualStoredProcedureName);
            Assert.AreEqual(expectedStoredProcedureName, actualStoredProcedureName);
            Assert.AreNotEqual(-1, actualExecutionTimeSeconds);
            Assert.IsTrue(actualExecutionTimeSeconds >= expectedExecutionTimeSeconds);
        }
    }
}