namespace Users.DataAccess.Database.Test.MSTest
{
    using Microsoft.VisualStudio.TestTools.UnitTesting;
    using System;
    using Users.DataAccess.Database.RepositoryContexts;
    using Users.DataAccess.DataModel.Types;
    using Users.TestFramework.Database;

    /// <summary>
    ///     Tests for the RepositoryContext class.
    /// </summary>
    [TestClass]
    public class RepositoryContextTest
    {
        /// <summary>
        ///     CancelChanges_MustCancelChangesIfBeginChangesWasCalledFirst.
        /// </summary>
        [TestMethod]
        public void CancelChanges_MustCancelChangesIfBeginChangesWasCalledFirst()
        {
            using (var repositoryContext = new RepositoryContext())
            {
                Account expectedAccount = TestEntities.GetTestAccount(
                    1,
                    Guid.Parse("ACFF5828-E613-4C63-91EF-9A676E181543"),
                    "RepCont");

                repositoryContext.BeginChanges();

                try
                {
                    repositoryContext.AccountRepository.Upsert(expectedAccount);
                    repositoryContext.CancelChanges();

                    Account actualAccount = repositoryContext.AccountRepository.Get(expectedAccount.AccountId);
                    Assert.IsNull(actualAccount);
                }
                finally
                {
                    if (expectedAccount.AccountId != TestValues.TestId)
                    {
                        repositoryContext.AccountRepository.Delete(expectedAccount.AccountId);
                    }
                }
            }
        }

        /// <summary>
        ///     CancelChanges_MustCancelChangesIfRepositoryWasCreatedFirst.
        /// </summary>
        [TestMethod]
        public void CancelChanges_MustCancelChangesIfRepositoryWasCreatedFirst()
        {
            using (var repositoryContext = new RepositoryContext())
            {
                Account expectedAccount = TestEntities.GetTestAccount(
                    1,
                    Guid.Parse("C53E531C-0B82-4DCA-80ED-7EB1A5B4A8FA"),
                    "RepCont");

                repositoryContext.BeginChanges();

                try
                {
                    repositoryContext.AccountRepository.Upsert(expectedAccount);
                    repositoryContext.CancelChanges();

                    Account actualAccount = repositoryContext.AccountRepository.Get(expectedAccount.AccountId);
                    Assert.IsNull(actualAccount);
                }
                finally
                {
                    if (expectedAccount.AccountId != TestValues.TestId)
                    {
                        repositoryContext.AccountRepository.Delete(expectedAccount.AccountId);
                    }
                }
            }
        }

        /// <summary>
        ///     MakingChanges_MustWorkBothInsideAndOutsideOfTransaction.
        /// </summary>
        [TestMethod]
        public void MakingChanges_MustWorkBothInsideAndOutsideOfTransaction()
        {
            using (var repositoryContext = new RepositoryContext())
            {
                Account expectedAccount1 = TestEntities.GetTestAccount(
                    1,
                    Guid.Parse("DCFEDC8C-8D04-471B-B36B-F106E6BE77DC"),
                    "RepCont");

                try
                {
                    repositoryContext.AccountRepository.Upsert(expectedAccount1);

                    Account actualAccount = repositoryContext.AccountRepository.Get(expectedAccount1.AccountId);
                    Assert.IsNotNull(actualAccount);
                    Assert.IsTrue(EntityComparer.AreAccountEqual(expectedAccount1, actualAccount));

                    Account expectedAccount2 = TestEntities.GetTestAccount(
                        1,
                        expectedAccount1?.AccountGuid.Value ?? null,
                        "RepCont");

                    repositoryContext.BeginChanges();
                    repositoryContext.AccountRepository.Upsert(expectedAccount2);
                    repositoryContext.SaveChanges();

                    actualAccount = repositoryContext.AccountRepository.Get(expectedAccount2.AccountId);
                    Assert.IsNotNull(actualAccount);
                    Assert.IsTrue(EntityComparer.AreAccountEqual(expectedAccount2, actualAccount));
                }
                finally
                {
                    if (expectedAccount1.AccountId != TestValues.TestId)
                    {
                        repositoryContext.AccountRepository.Delete(expectedAccount1.AccountId);
                    }
                }
            }
        }

        /// <summary>
        ///     SaveChanges_MustSaveChangesIfBeginChangesWasCalledFirst.
        /// </summary>
        [TestMethod]
        public void SaveChanges_MustSaveChangesIfBeginChangesWasCalledFirst()
        {
            using (var repositoryContext = new RepositoryContext())
            {
                Account expectedAccount = TestEntities.GetTestAccount(
                    1,
                    Guid.Parse("E51C8347-5F11-40EB-8284-3960E98FEB37"),
                    "RepCont");

                repositoryContext.BeginChanges();

                try
                {
                    repositoryContext.AccountRepository.Upsert(expectedAccount);
                    repositoryContext.SaveChanges();

                    Account actualAccount = repositoryContext.AccountRepository.Get(expectedAccount.AccountId);
                    Assert.IsNotNull(actualAccount);
                    Assert.IsTrue(EntityComparer.AreAccountEqual(expectedAccount, actualAccount));
                }
                finally
                {
                    if (expectedAccount.AccountId != TestValues.TestId)
                    {
                        repositoryContext.AccountRepository.Delete(expectedAccount.AccountId);
                    }
                }
            }
        }

        /// <summary>
        ///     SaveChanges_MustSaveChangesIfRepositoryWasCreatedFirst.
        /// </summary>
        [TestMethod]
        public void SaveChanges_MustSaveChangesIfRepositoryWasCreatedFirst()
        {
            using (var repositoryContext = new RepositoryContext())
            {
                Account expectedAccount = TestEntities.GetTestAccount(
                    1,
                    Guid.Parse("3DA9A385-A97C-4D63-BD4F-2230BD7B97B2"),
                    "RepCont");

                repositoryContext.BeginChanges();

                try
                {
                    repositoryContext.AccountRepository.Upsert(expectedAccount);
                    repositoryContext.SaveChanges();

                    Account actualAccount = repositoryContext.AccountRepository.Get(expectedAccount.AccountId);
                    Assert.IsNotNull(actualAccount);
                    Assert.IsTrue(EntityComparer.AreAccountEqual(expectedAccount, actualAccount));
                }
                finally
                {
                    if (expectedAccount.AccountId != TestValues.TestId)
                    {
                        repositoryContext.AccountRepository.Delete(expectedAccount.AccountId);
                    }
                }
            }
        }
    }
}