namespace Users.TestFramework.Database
{
    using System;
    using Users.DataAccess.Repository;

    /// <summary>
    ///     Test data cleaner.
    /// </summary>
    public class TestDataCleaner
    {
        /// <summary>
        ///     Deletes test account.
        /// </summary>
        /// <param name="repositoryContext">Repository context.</param>
        /// <param name="accountGuid">Account unique identifier.</param>
        public static void DeleteTestAccount(
            IRepositoryContext repositoryContext,
            Guid accountGuid)
        {
            int? accountId = repositoryContext.AccountRepository.GetId(accountGuid);
            if (accountId != null)
            {
                repositoryContext.AccountRepository.Delete(accountId.Value);
            }
        }
    }
}