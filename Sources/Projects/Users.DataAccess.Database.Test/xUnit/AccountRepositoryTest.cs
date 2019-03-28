namespace Users.DataAccess.Database.Test.xUnit
{
    using System;
    using System.ComponentModel.DataAnnotations;
    using Users.DataAccess.Database.RepositoryContexts;
    using Users.DataAccess.DataModel.Types;
    using Users.TestFramework.Database;
    using Xunit;

    /// <summary>
    ///     Tests for the AccountRepository class.
    /// </summary>
    public class AccountRepositoryTest
    {
        /// <summary>
        ///     UpsertAccount_ThrowsValidationExceptionAccountNumberIsInvalid.
        /// </summary>
        /// <param name="invalidString">Invalid string.</param>
        [Theory]
        [MemberData(nameof(TestValues.InvalidAndLongStrings), MemberType = typeof(TestValues))]
        public void UpsertAccount_ThrowsValidationExceptionIfAccountNumberIsInvalid(string invalidString)
        {
            using (var repositoryContext = new RepositoryContext())
            {
                Account account = TestEntities.GetTestAccount(1, Guid.Empty, TestValues.ValidString);
                account.AccountNumber = invalidString;
                Assert.Throws<ValidationException>(() => repositoryContext.AccountRepository.Upsert(account));
            }
        }

        /// <summary>
        ///     UpsertAccount_ThrowsValidationExceptionIfAccountNameIsInvalid.
        /// </summary>
        /// <param name="invalidString">Invalid string.</param>
        [Theory]
        [MemberData(nameof(TestValues.InvalidAndLongStrings), MemberType = typeof(TestValues))]
        public void UpsertAccount_ThrowsValidationExceptionIfAccountNameIsInvalid(string invalidString)
        {
            using (var repositoryContext = new RepositoryContext())
            {
                Account account = TestEntities.GetTestAccount(1, Guid.Empty, TestValues.ValidString);
                account.AccountName = invalidString;
                Assert.Throws<ValidationException>(() => repositoryContext.AccountRepository.Upsert(account));
            }
        }

        /// <summary>
        ///     CRUD tests.
        /// </summary>
        [Fact]
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
                Assert.NotNull(actualAccount);
                Assert.True(EntityComparer.AreAccountEqual(expectedAccount, actualAccount));

                if (expectedAccount.AccountGuid.HasValue)
                {
                    // read by guid
                    actualAccount = repositoryContext.AccountRepository.Get(expectedAccount.AccountGuid.Value);
                    Assert.NotNull(actualAccount);
                    Assert.True(EntityComparer.AreAccountEqual(expectedAccount, actualAccount));
                }

                int? actualAccountId;

                if (expectedAccount.AccountGuid.HasValue)
                {
                    // read id by guid
                    actualAccountId = repositoryContext.AccountRepository.GetId(expectedAccount.AccountGuid.Value);
                    Assert.Equal(expectedAccount.AccountId, actualAccountId);
                }

                // read id by account number
                actualAccountId = repositoryContext.AccountRepository.GetId(expectedAccount.AccountNumber);
                Assert.Equal(expectedAccount.AccountId, actualAccountId);

                // update
                Account expectedAccountNew =
                    TestEntities.GetTestAccount(2, expectedAccount.AccountGuid.Value, "AccNew");
                repositoryContext.AccountRepository.Upsert(expectedAccountNew);
                Assert.Equal(expectedAccount.AccountId, expectedAccountNew.AccountId);

                Account actualAccountNew = repositoryContext.AccountRepository.Get(expectedAccountNew.AccountId);
                Assert.NotNull(actualAccountNew);
                Assert.True(EntityComparer.AreAccountEqual(expectedAccountNew, actualAccountNew));

                // delete
                repositoryContext.AccountRepository.Delete(expectedAccount.AccountId);

                // read by id
                actualAccount = repositoryContext.AccountRepository.Get(expectedAccount.AccountId);
                Assert.Null(actualAccount);

                if (expectedAccount.AccountGuid.HasValue)
                {
                    // read by guid
                    actualAccount = repositoryContext.AccountRepository.Get(expectedAccount.AccountGuid.Value);
                    Assert.Null(actualAccount);

                    // read id by guid
                    actualAccountId = repositoryContext.AccountRepository.GetId(expectedAccount.AccountGuid.Value);
                    Assert.Null(actualAccountId);
                }

                // read id by account number
                actualAccountId = repositoryContext.AccountRepository.GetId(expectedAccount.AccountNumber);
                Assert.Null(actualAccountId);
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
        [Fact]
        public void UpsertAccount_ThrowsArgumentNullExceptionIfAccountNull()
        {
            using (var repositoryContext = new RepositoryContext())
            {
                Assert.Throws<ArgumentNullException>(() => repositoryContext.AccountRepository.Upsert(null));
            }
        }
    }
}