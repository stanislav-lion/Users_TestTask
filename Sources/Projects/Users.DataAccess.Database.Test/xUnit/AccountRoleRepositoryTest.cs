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
    ///     Tests for the AccountRoleRepository class.
    /// </summary>
    public class AccountRoleRepositoryTest
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
                Guid.Parse("64651A7C-CB82-4F45-92CA-397AD8519D75"),
                "AccRole");

            try
            {
                // delete test account
                TestDataCleaner.DeleteTestAccount(repositoryContext, testAccount.AccountId);

                // create account
                repositoryContext.AccountRepository.Upsert(testAccount);

                // create
                AccountRole expectedAccountRole = TestEntities.GetTestAccountRole(
                    1,
                    Guid.Parse("7B46F4DD-1E5E-47F9-ADBB-A37A60B1BAB2"),
                    testAccount.AccountId,
                    "AccRoleOld");
                repositoryContext.AccountRoleRepository.Upsert(expectedAccountRole);

                // read by id
                AccountRole actualAccountRole =
                    repositoryContext.AccountRoleRepository.Get(expectedAccountRole.AccountRoleId);
                Assert.NotNull(actualAccountRole);
                Assert.True(EntityComparer.AreAccountRoleEqual(expectedAccountRole, actualAccountRole));

                if (expectedAccountRole.AccountRoleGuid.HasValue)
                {
                    // read by guid
                    actualAccountRole =
                        repositoryContext.AccountRoleRepository.Get(expectedAccountRole.AccountRoleGuid.Value);
                    Assert.NotNull(actualAccountRole);
                    Assert.True(EntityComparer.AreAccountRoleEqual(expectedAccountRole, actualAccountRole));
                }

                int? actualAccountRoleId;

                if (expectedAccountRole.AccountRoleGuid.HasValue)
                {
                    // read id by guid
                    actualAccountRoleId =
                        repositoryContext.AccountRoleRepository.GetId(expectedAccountRole.AccountRoleGuid.Value);
                    Assert.Equal(expectedAccountRole.AccountRoleId, actualAccountRoleId);
                }

                // read id by account id and role name
                actualAccountRoleId = repositoryContext.AccountRoleRepository.GetId(
                    expectedAccountRole.AccountId,
                    expectedAccountRole.RoleName);
                Assert.Equal(expectedAccountRole.AccountRoleId, actualAccountRoleId);

                // update
                AccountRole expectedAccountRoleNew = TestEntities.GetTestAccountRole(
                    2,
                    expectedAccountRole?.AccountRoleGuid.Value ?? null,
                    expectedAccountRole.AccountId,
                    "AccRoleNew");

                expectedAccountRoleNew.AccountRoleGuid = expectedAccountRole.AccountRoleGuid;
                repositoryContext.AccountRoleRepository.Upsert(expectedAccountRoleNew);
                Assert.Equal(expectedAccountRole.AccountRoleId, expectedAccountRoleNew.AccountRoleId);

                AccountRole actualAccountRoleNew =
                    repositoryContext.AccountRoleRepository.Get(expectedAccountRoleNew.AccountRoleId);
                Assert.NotNull(actualAccountRoleNew);
                Assert.True(EntityComparer.AreAccountRoleEqual(expectedAccountRoleNew, actualAccountRoleNew));

                // delete
                repositoryContext.AccountRoleRepository.Delete(expectedAccountRoleNew.AccountRoleId);

                // read by id
                actualAccountRole = repositoryContext.AccountRoleRepository.Get(expectedAccountRoleNew.AccountRoleId);
                Assert.Null(actualAccountRole);

                if (expectedAccountRoleNew.AccountRoleGuid.HasValue)
                {
                    // read by guid
                    actualAccountRole =
                        repositoryContext.AccountRoleRepository.Get(expectedAccountRoleNew.AccountRoleGuid.Value);
                    Assert.Null(actualAccountRole);

                    // read id by guid
                    actualAccountRoleId =
                        repositoryContext.AccountRoleRepository.GetId(expectedAccountRoleNew.AccountRoleGuid.Value);
                    Assert.Null(actualAccountRoleId);
                }
                
                // read id by account id and role number
                actualAccountRoleId = repositoryContext.AccountRoleRepository.GetId(
                    expectedAccountRoleNew.AccountId,
                    expectedAccountRoleNew.RoleName);
                Assert.Null(actualAccountRoleId);

                // test by account

                // create account roles
                var expectedAccountRoles = new List<AccountRole>
                {
                    TestEntities.GetTestAccountRole(
                        1,
                        Guid.Parse("AF8F597E-82A3-4184-932D-6AA31DA4E6F2"),
                        testAccount.AccountId,
                        "AccRole1")
                };

                foreach (AccountRole accountRole in expectedAccountRoles)
                {
                    repositoryContext.AccountRoleRepository.Upsert(accountRole);
                }
                
                // read by account
                var actualAccountRoles = new List<AccountRole>
                {
                    repositoryContext.AccountRoleRepository.GetByAccount(testAccount.AccountId)
                };
                Assert.Equal(expectedAccountRoles.Count, actualAccountRoles.Count);

                foreach (AccountRole accountRole in expectedAccountRoles)
                {
                    actualAccountRole =
                        actualAccountRoles.Single(ar => ar.AccountRoleGuid == accountRole.AccountRoleGuid);
                    Assert.True(EntityComparer.AreAccountRoleEqual(accountRole, actualAccountRole));
                }

                // delete by account
                repositoryContext.AccountRoleRepository.DeleteByAccount(testAccount.AccountId);

                // read by account
                actualAccountRoles = new List<AccountRole>
                {
                    repositoryContext.AccountRoleRepository.GetByAccount(testAccount.AccountId)

                };
                Assert.Empty(actualAccountRoles);
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