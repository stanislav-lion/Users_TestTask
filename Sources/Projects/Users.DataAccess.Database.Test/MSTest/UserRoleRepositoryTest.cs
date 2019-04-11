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
    ///     Tests for the UserRoleRepository class.
    /// </summary>
    [TestClass]
    public class UserRoleRepositoryTest
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
                Guid.Parse("DA8306F8-B255-4737-925C-AACCA7EB2B87"),
                "UserRole");

            try
            {
                // delete test account
                TestDataCleaner.DeleteTestAccount(repositoryContext, testAccount.AccountId);

                // create account
                repositoryContext.AccountRepository.Upsert(testAccount);

                // create account roles
                AccountRole testAccountRole1 = TestEntities.GetTestAccountRole(
                    1,
                    Guid.Parse("FFDEA1D7-78BA-414C-8A7B-A3B09A50DDF2"),
                    testAccount.AccountId,
                    "UserRole1");

                repositoryContext.AccountRoleRepository.Upsert(testAccountRole1);

                AccountRole testAccountRole2 = TestEntities.GetTestAccountRole(
                    2,
                    Guid.Parse("B0775CA4-7339-4127-BDF3-440B85F71AC5"),
                    testAccount.AccountId,
                    "UserRole2");
                repositoryContext.AccountRoleRepository.Upsert(testAccountRole2);

                // create user
                User testUser = TestEntities.GetTestUser(
                    1,
                    Guid.Parse("EE837AA8-D3B8-47D4-B5DF-23E389BCFBA4"),
                    "UserRole",
                    testAccount.AccountId);
                repositoryContext.UserRepository.Upsert(testUser);

                // create
                UserRole expectedUserRole = TestEntities.GetTestUserRole(
                    testUser.UserId,
                    testAccountRole1.AccountRoleId);
                repositoryContext.UserRoleRepository.Add(expectedUserRole);

                // read
                UserRole actualUserRole = repositoryContext.UserRoleRepository.Get(
                    expectedUserRole.UserId,
                    expectedUserRole.AccountRoleId);
                Assert.IsNotNull(actualUserRole);
                Assert.IsTrue(EntityComparer.AreUserRoleEqual(expectedUserRole, actualUserRole));

                // delete
                repositoryContext.UserRoleRepository.Delete(expectedUserRole.UserId, expectedUserRole.AccountRoleId);

                // read
                actualUserRole = repositoryContext.UserRoleRepository.Get(
                    expectedUserRole.UserId,
                    expectedUserRole.AccountRoleId);
                Assert.IsNull(actualUserRole);

                // test by user

                // create user roles
                var expectedUserRoles = new List<UserRole>
                {
                    TestEntities.GetTestUserRole(testUser.UserId, testAccountRole1.AccountRoleId),
                    TestEntities.GetTestUserRole(testUser.UserId, testAccountRole2.AccountRoleId)
                };

                foreach (UserRole userRole in expectedUserRoles)
                {
                    repositoryContext.UserRoleRepository.Add(userRole);
                }

                // read by user
                List<UserRole> actualUserRoles = repositoryContext.UserRoleRepository.Get(testUser.UserId);
                Assert.AreEqual(expectedUserRoles.Count, actualUserRoles.Count);

                foreach (UserRole userRole in expectedUserRoles)
                {
                    actualUserRole =
                        actualUserRoles.Single(
                            ur => ur.UserId == userRole.UserId && ur.AccountRoleId == userRole.AccountRoleId);
                    Assert.IsTrue(EntityComparer.AreUserRoleEqual(userRole, actualUserRole));
                }

                // delete by user
                repositoryContext.UserRoleRepository.Delete(testUser.UserId);

                // read by user
                actualUserRoles = repositoryContext.UserRoleRepository.Get(testUser.UserId);
                Assert.IsNull(actualUserRoles);
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