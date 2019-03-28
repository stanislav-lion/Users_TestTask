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
        /// <param name="accountGuid">Account identifier.</param>
        public static void DeleteTestAccount(
            IRepositoryContext repositoryContext,
            int accountId)
        {
            repositoryContext.AccountRepository.Delete(accountId);
        }

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

            if (accountId.HasValue)
            {
                repositoryContext.AccountRepository.Delete(accountId.Value);
            }
        }
    }
}