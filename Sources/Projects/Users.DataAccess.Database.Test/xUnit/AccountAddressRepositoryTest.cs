namespace Users.DataAccess.Database.Test.xUnit
{
    using System;
    using Users.DataAccess.Database.RepositoryContexts;
    using Users.DataAccess.DataModel.Types;
    using Users.TestFramework.Database;
    using Xunit;
    
    /// <summary>
    ///     Tests for the AccountAddressRepository class.
    /// </summary>
    public class AccountAddressRepositoryTest
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
                Guid.Parse("F341B4FB-4CC3-4FDB-B7CF-8DCD45365341"),
                "AccAddr");

            try
            {
                // delete test account
                TestDataCleaner.DeleteTestAccount(repositoryContext, testAccount.AccountId);

                // create account
                repositoryContext.AccountRepository.Upsert(testAccount);

                // create
                AccountAddress expectedAccountAddress = TestEntities.GetTestAccountAddress(1, testAccount.AccountId);
                repositoryContext.AccountAddressRepository.Upsert(expectedAccountAddress);

                // read
                AccountAddress actualAccountAddress =
                    repositoryContext.AccountAddressRepository.Get(expectedAccountAddress.AccountId);
                Assert.NotNull(actualAccountAddress);
                Assert.True(EntityComparer.AreAccountAddressEqual(expectedAccountAddress, actualAccountAddress));

                // update
                AccountAddress expectedAccountAddressNew = TestEntities.GetTestAccountAddress(
                    2,
                    expectedAccountAddress.AccountId);

                repositoryContext.AccountAddressRepository.Upsert(expectedAccountAddressNew);
                Assert.Equal(expectedAccountAddress.AccountId, expectedAccountAddressNew.AccountId);

                AccountAddress actualAccountAddressNew =
                    repositoryContext.AccountAddressRepository.Get(expectedAccountAddressNew.AccountId);
                Assert.NotNull(actualAccountAddressNew);
                Assert.True(
                    EntityComparer.AreAccountAddressEqual(expectedAccountAddressNew, actualAccountAddressNew));

                // delete
                repositoryContext.AccountRepository.Delete(expectedAccountAddress.AccountId);

                // read by id
                actualAccountAddress =
                    repositoryContext.AccountAddressRepository.Get(expectedAccountAddress.AccountId);
                Assert.Null(actualAccountAddress);
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