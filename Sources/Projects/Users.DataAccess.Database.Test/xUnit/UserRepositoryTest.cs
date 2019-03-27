namespace Users.DataAccess.Database.Test.xUnit
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using Users.DataAccess.Database.RepositoryContexts;
    using Users.DataAccess.DataModel.Types;
    using Users.TestFramework.Database;
    using Xunit;

    /// <summary>
    ///     Tests for the UserRepository class.
    /// </summary>
    public class UserRepositoryTest
    {
        /// <summary>
        ///     CRUD tests.
        /// </summary>
        [Fact]
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
                TestDataCleaner.DeleteTestAccount(repositoryContext, testAccount.AccountGuid.Value);

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
                Assert.NotNull(actualUser);
                Assert.True(EntityComparer.AreUserEqual(expectedUser, actualUser));

                // read by guid
                if (expectedUser.UserGuid.HasValue)
                {
                    actualUser = repositoryContext.UserRepository.Get(expectedUser.UserGuid.Value);
                    Assert.NotNull(actualUser);
                    Assert.True(EntityComparer.AreUserEqual(expectedUser, actualUser));
                }

                // read by logon name
                actualUser = repositoryContext.UserRepository.Get(expectedUser.LogonName);
                Assert.NotNull(actualUser);
                Assert.True(EntityComparer.AreUserEqual(expectedUser, actualUser));

                int? actualUserId;

                // read id by guid
                if (expectedUser.UserGuid.HasValue)
                {
                    actualUserId = repositoryContext.UserRepository.GetId(expectedUser.UserGuid.Value);
                    Assert.Equal(expectedUser.UserId, actualUserId);
                }

                // read id by logon name
                actualUserId = repositoryContext.UserRepository.GetId(expectedUser.LogonName);
                Assert.Equal(expectedUser.UserId, actualUserId);

                // update
                User expectedUserNew = TestEntities.GetTestUser(
                    2,
                    expectedUser.UserGuid.Value,
                    "UserNew",
                    expectedUser.AccountId);

                repositoryContext.UserRepository.Upsert(expectedUserNew);
                Assert.Equal(expectedUser.UserId, expectedUserNew.UserId);

                User actualUserNew = repositoryContext.UserRepository.Get(expectedUserNew.UserId);
                Assert.NotNull(actualUserNew);
                Assert.True(EntityComparer.AreUserEqual(expectedUserNew, actualUserNew));

                // delete
                repositoryContext.UserRepository.Delete(expectedUserNew.UserId);

                // read by id
                actualUser = repositoryContext.UserRepository.Get(expectedUserNew.UserId);
                Assert.Null(actualUser);

                // read by guid
                actualUser = repositoryContext.UserRepository.Get(expectedUserNew.UserGuid.Value);
                Assert.Null(actualUser);

                // read by logon name
                actualUser = repositoryContext.UserRepository.Get(expectedUser.LogonName);
                Assert.Null(actualUser);

                if (expectedUserNew.UserGuid.HasValue)
                {
                    // read id by guid
                    actualUserId = repositoryContext.UserRepository.GetId(expectedUserNew.UserGuid.Value);
                    Assert.Null(actualUserId);
                }

                // read id by logon name
                actualUserId = repositoryContext.UserRepository.GetId(expectedUserNew.LogonName);
                Assert.Null(actualUserId);

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
                Assert.Equal(expectedUsers.Count, actualUsers.Count);

                foreach (User user in expectedUsers)
                {
                    actualUser = actualUsers.Single(ar => ar.UserGuid == user.UserGuid);
                    Assert.True(EntityComparer.AreUserEqual(user, actualUser));
                }

                // delete by account
                repositoryContext.UserRepository.DeleteByAccount(testAccount.AccountId);

                // read by account
                actualUsers = repositoryContext.UserRepository.GetByAccount(testAccount.AccountId);
                Assert.Empty(actualUsers);
            }
            finally
            {
                // delete test account
                TestDataCleaner.DeleteTestAccount(repositoryContext, testAccount.AccountGuid.Value);

                repositoryContext.Dispose();
            }
        }
    }
}