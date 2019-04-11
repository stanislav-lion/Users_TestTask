namespace Users.DataAccess.Database.Test.MSTest
{
    using Microsoft.VisualStudio.TestTools.UnitTesting;
    using System;
    using Users.DataAccess.Database.RepositoryContexts;
    using Users.DataAccess.DataModel.Types;
    using Users.TestFramework.Database;

    /// <summary>
    ///     Tests for the AccountRepository class.
    /// </summary>
    [TestClass]
    public class AccountRepositoryTest
    {
        /// <summary>
        ///     CRUD tests.
        /// </summary>
        [TestMethod]
        public void CRUD_Test()
        {
            var repositoryContext = new RepositoryContext();

            Account expectedAccount = TestEntities.GetTestAccount(
                1,
                Guid.Parse("B2A4DF0B-B0B4-46E6-A308-6DFB79909CD3"),
                "AccOld");

            try
            {
                // delete test account
                TestDataCleaner.DeleteTestAccount(repositoryContext, expectedAccount.AccountId);

                // create
                repositoryContext.AccountRepository.Upsert(expectedAccount);

                // read by id
                Account actualAccount = repositoryContext.AccountRepository.Get(expectedAccount.AccountId);
                Assert.IsNotNull(actualAccount);
                Assert.IsTrue(EntityComparer.AreAccountEqual(expectedAccount, actualAccount));

                if (expectedAccount.AccountGuid.HasValue)
                {
                    // read by guid
                    actualAccount = repositoryContext.AccountRepository.Get(expectedAccount.AccountGuid.Value);
                    Assert.IsNotNull(actualAccount);
                    Assert.IsTrue(EntityComparer.AreAccountEqual(expectedAccount, actualAccount));
                }

                int? actualAccountId;

                if (expectedAccount.AccountGuid.HasValue)
                {
                    // read id by guid
                    actualAccountId = repositoryContext.AccountRepository.GetId(expectedAccount.AccountGuid.Value);
                    Assert.AreEqual(expectedAccount.AccountId, actualAccountId);
                }

                // read id by account number
                actualAccountId = repositoryContext.AccountRepository.GetId(expectedAccount.AccountNumber);
                Assert.AreEqual(expectedAccount.AccountId, actualAccountId);

                // update
                Account expectedAccountNew =
                    TestEntities.GetTestAccount(2, expectedAccount.AccountGuid.Value, "AccNew");
                repositoryContext.AccountRepository.Upsert(expectedAccountNew);
                Assert.AreEqual(expectedAccount.AccountId, expectedAccountNew.AccountId);

                Account actualAccountNew = repositoryContext.AccountRepository.Get(expectedAccountNew.AccountId);
                Assert.IsNotNull(actualAccountNew);
                Assert.IsTrue(EntityComparer.AreAccountEqual(expectedAccountNew, actualAccountNew));

                // delete
                repositoryContext.AccountRepository.Delete(expectedAccount.AccountId);

                // read by id
                actualAccount = repositoryContext.AccountRepository.Get(expectedAccount.AccountId);
                Assert.IsNull(actualAccount);

                if (expectedAccount.AccountGuid.HasValue)
                {
                    // read by guid
                    actualAccount = repositoryContext.AccountRepository.Get(expectedAccount.AccountGuid.Value);
                    Assert.IsNull(actualAccount);

                    // read id by guid
                    actualAccountId = repositoryContext.AccountRepository.GetId(expectedAccount.AccountGuid.Value);
                    Assert.IsNull(actualAccountId);
                }

                // read id by account number
                actualAccountId = repositoryContext.AccountRepository.GetId(expectedAccount.AccountNumber);
                Assert.IsNull(actualAccountId);
            }
            finally
            {
                // delete test account
                TestDataCleaner.DeleteTestAccount(repositoryContext, expectedAccount.AccountId);

                repositoryContext.Dispose();
            }
        }

        /// <summary>
        ///     UpsertAccount_ThrowsArgumentNullExceptionIfAccountNull
        /// </summary>
        [TestMethod]
        public void UpsertAccount_ThrowsArgumentNullExceptionIfAccountNull()
        {
            using (var repositoryContext = new RepositoryContext())
            {
                Assert.ThrowsException<ArgumentNullException>(() => repositoryContext.AccountRepository.Upsert(null));
            }
        }
    }
}