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
        /// <returns>The number of state entries written to the database.</returns>
        public static int DeleteTestAccount(
            IRepositoryContext repositoryContext,
            int accountId)
        {
            return repositoryContext.AccountRepository.Delete(accountId);
        }

        /// <summary>
        ///     Deletes test account.
        /// </summary>
        /// <param name="repositoryContext">Repository context.</param>
        /// <param name="accountGuid">Account unique identifier.</param>
        /// <returns>The number of state entries written to the database.</returns>
        public static int DeleteTestAccount(
            IRepositoryContext repositoryContext,
            Guid accountGuid)
        {
            int? accountId = repositoryContext.AccountRepository.GetId(accountGuid);

            if (accountId.HasValue)
            {
                return repositoryContext.AccountRepository.Delete(accountId.Value);
            }

            return 0;
        }
    }
}