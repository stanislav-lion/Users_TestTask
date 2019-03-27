namespace Users.TestFramework.Database
{
    using System;
    using Users.DataAccess.DataModel.Types;

    /// <summary>
    ///     Class that creates test entities.
    /// </summary>
    public static class TestEntities
    {
        /// <summary>
        ///     Create test account.
        /// </summary>
        /// <param name="number">Number.</param>
        /// <param name="accountGuid">Account unique identifier.</param>
        /// <param name="accountNumber">Account number.</param>
        /// <returns>Account</returns>
        public static Account GetTestAccount(
            int number,
            Guid accountGuid,
            string accountNumber)
        {
            return new Account
            {
                AccountId = TestValues.TestId,
                AccountGuid = accountGuid,
                AccountNumber = accountNumber,
                AccountName = number.ToString(),
                IsEnabled = Convert.ToBoolean(number % 2),
                TimeZone = number,
                PasswordExpirationPeriodInDays = number,
                DataStorageTimeHrs = number,
                NumberOfCodeManagementApps = number
            };
        }

        /// <summary>
        ///     Create test user.
        /// </summary>
        /// <param name="number">Number.</param>
        /// <param name="userGuid">User unique identifier.</param>
        /// <param name="logonName">Logon name</param>
        /// <param name="accountId">Account identifier.</param>
        /// <returns>User</returns>
        public static User GetTestUser(
            int number,
            Guid userGuid,
            string logonName,
            int accountId)
        {
            return new User
            {
                UserId = TestValues.TestId,
                UserGuid = userGuid,
                LogonName = logonName,
                AccountId = accountId,
                FirstName = number.ToString(),
                LastName = number.ToString(),
                MiddleName = number.ToString(),
                PasswordSalt = number.ToString(),
                PasswordHash = number.ToString(),
                PasswordChangeUtc = TestValues.TestDateTime.AddDays(number),
                PasswordMustBeChanged = Convert.ToBoolean(number % 2),
                IsLogonEnabled = Convert.ToBoolean(number % 2),
                TimeZone = number,
                CultureCode = number.ToString()
            };
        }
    }
}