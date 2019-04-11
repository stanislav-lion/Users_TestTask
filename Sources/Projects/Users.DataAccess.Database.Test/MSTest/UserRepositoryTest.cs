namespace Users.DataAccess.Database.Test.MSTest
{
    using Microsoft.VisualStudio.TestTools.UnitTesting;
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using Users.DataAccess.Database.RepositoryContexts;
    using Users.DataAccess.DataModel.Types;
    using Users.TestFramework.Database;

    /// <summary>
    ///     Tests for the UserRepository class.
    /// </summary>
    [TestClass]
    public class UserRepositoryTest
    {
        /// <summary>
        ///     CRUD tests.
        /// </summary>
        [TestMethod]
        public void CRUD_Test()
        {
            var repositoryContext = new RepositoryContext();

            Account testAccount = TestEntities.GetTestAccount(
                1,
                Guid.Parse("579526DD-D75C-46E2-8A30-A1D3828F92A5"),
                "UserOld");

            try
            {
                // delete test account
                TestDataCleaner.DeleteTestAccount(repositoryContext, testAccount.AccountId);

                // create account
                repositoryContext.AccountRepository.Upsert(testAccount);

                // create
                User expectedUser = TestEntities.GetTestUser(
                    1,
                    Guid.Parse("86641E45-CB9C-4CC3-93EB-E6D26FDC91BE"),
                    "User",
                    testAccount.AccountId);

                repositoryContext.UserRepository.Upsert(expectedUser);

                // read by id
                User actualUser = repositoryContext.UserRepository.Get(expectedUser.UserId);
                Assert.IsNotNull(actualUser);
                Assert.IsTrue(EntityComparer.AreUserEqual(expectedUser, actualUser));

                // read by guid
                if (expectedUser.UserGuid.HasValue)
                {
                    actualUser = repositoryContext.UserRepository.Get(expectedUser.UserGuid.Value);
                    Assert.IsNotNull(actualUser);
                    Assert.IsTrue(EntityComparer.AreUserEqual(expectedUser, actualUser));
                }

                // read by logon name
                actualUser = repositoryContext.UserRepository.Get(expectedUser.LogonName);
                Assert.IsNotNull(actualUser);
                Assert.IsTrue(EntityComparer.AreUserEqual(expectedUser, actualUser));

                int? actualUserId;

                // read id by guid
                if (expectedUser.UserGuid.HasValue)
                {
                    actualUserId = repositoryContext.UserRepository.GetId(expectedUser.UserGuid.Value);
                    Assert.AreEqual(expectedUser.UserId, actualUserId);
                }

                // read id by logon name
                actualUserId = repositoryContext.UserRepository.GetId(expectedUser.LogonName);
                Assert.AreEqual(expectedUser.UserId, actualUserId);

                // update
                User expectedUserNew = TestEntities.GetTestUser(
                    2,
                    expectedUser?.UserGuid.Value ?? null,
                    "UserNew",
                    expectedUser.AccountId);

                repositoryContext.UserRepository.Upsert(expectedUserNew);
                Assert.AreEqual(expectedUser.UserId, expectedUserNew.UserId);

                User actualUserNew = repositoryContext.UserRepository.Get(expectedUserNew.UserId);
                Assert.IsNotNull(actualUserNew);
                Assert.IsTrue(EntityComparer.AreUserEqual(expectedUserNew, actualUserNew));

                // delete
                repositoryContext.UserRepository.Delete(expectedUserNew.UserId);

                // read by id
                actualUser = repositoryContext.UserRepository.Get(expectedUserNew.UserId);
                Assert.IsNull(actualUser);

                if (expectedUserNew.UserGuid.HasValue)
                {
                    // read by guid
                    actualUser = repositoryContext.UserRepository.Get(expectedUserNew.UserGuid.Value);
                    Assert.IsNull(actualUser);
                }

                // read by logon name
                actualUser = repositoryContext.UserRepository.Get(expectedUser.LogonName);
                Assert.IsNull(actualUser);

                if (expectedUserNew.UserGuid.HasValue)
                {
                    // read id by guid
                    actualUserId = repositoryContext.UserRepository.GetId(expectedUserNew.UserGuid.Value);
                    Assert.IsNull(actualUserId);
                }

                // read id by logon name
                actualUserId = repositoryContext.UserRepository.GetId(expectedUserNew.LogonName);
                Assert.IsNull(actualUserId);

                // test by account

                // create users
                var expectedUsers = new List<User>
                {
                    TestEntities.GetTestUser(
                        1,
                        Guid.Parse("5B446BFB-7BCF-4A49-84EA-EB8D738F11DF"),
                        "User1",
                        testAccount.AccountId),

                    TestEntities.GetTestUser(
                        2,
                        Guid.Parse("EC15A8F5-941B-4C46-8EDA-83CD5B42E482"),
                        "User2",
                        testAccount.AccountId)
                };

                foreach (User user in expectedUsers)
                {
                    repositoryContext.UserRepository.Upsert(user);
                }

                // read by account
                List<User> actualUsers = repositoryContext.UserRepository.GetByAccount(testAccount.AccountId);
                Assert.AreEqual(expectedUsers.Count, actualUsers.Count);

                foreach (User user in expectedUsers)
                {
                    actualUser = actualUsers.Single(ar => ar.UserGuid == user.UserGuid);
                    Assert.IsTrue(EntityComparer.AreUserEqual(user, actualUser));
                }

                // delete by account
                repositoryContext.UserRepository.DeleteByAccount(testAccount.AccountId);

                // read by account
                actualUsers = repositoryContext.UserRepository.GetByAccount(testAccount.AccountId);
                Assert.IsNull(actualUsers);
            }
            finally
            {
                // delete test account
                TestDataCleaner.DeleteTestAccount(repositoryContext, testAccount.AccountId);

                repositoryContext.Dispose();
            }
        }
    }
}