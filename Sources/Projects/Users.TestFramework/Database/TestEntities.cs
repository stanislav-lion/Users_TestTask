namespace Users.TestFramework.Database
{
    using System;
    using Users.DataAccess.DataModel.Enums;
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
        /// <returns>Account.</returns>
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
        ///     Create test account role.
        /// </summary>
        /// <param name="number">Number.</param>
        /// <param name="accountRoleGuid">Account role unique identifier.</param>
        /// <param name="accountId">Account identifier.</param>
        /// <param name="roleName">Role name.</param>
        /// <returns>Account role.</returns>
        public static AccountRole GetTestAccountRole(
            int number,
            Guid? accountRoleGuid,
            int accountId,
            string roleName)
        {
            return new AccountRole
            {
                AccountRoleId = TestValues.TestId,
                AccountRoleGuid = accountRoleGuid,
                AccountId = accountId,
                RoleName = roleName,
                RoleType = IntToEnum<RoleType>(number),
                PrivilegeType = IntToEnum<PrivilegeType>(number)
            };
        }

        /// <summary>
        ///     Create test account address.
        /// </summary>
        /// <param name="number">Number.</param>
        /// <param name="accountId">Account identifier.</param>
        /// <returns>Account address.</returns>
        public static AccountAddress GetTestAccountAddress(
            int number, 
            int accountId)
        {
            if (number > 99)
            {
                throw new ArgumentException("Number for CountryTwoLetterCode is invalid");
            }

            return new AccountAddress
            {
                AccountId = accountId,
                AddressLine1 = number.ToString(),
                AddressLine2 = number.ToString(),
                AddressLine3 = number.ToString(),
                AddressType = IntToEnum<AddressType>(number),
                City = number.ToString(),
                CountryTwoLetterCode = (number + 10).ToString(),
                County = number.ToString(),
                PostalCode = number.ToString(),
                StateProvince = number.ToString()
            };
        }

        /// <summary>
        ///     Create test user.
        /// </summary>
        /// <param name="number">Number.</param>
        /// <param name="userGuid">User unique identifier.</param>
        /// <param name="logonName">Logon name.</param>
        /// <param name="accountId">Account identifier.</param>
        /// <returns>User.</returns>
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

        /// <summary>
        ///     Create test user role.
        /// </summary>
        /// <param name="userId">User unique identifier.</param>
        /// <param name="accountRoleId">Account role identifier.</param>
        /// <returns>User role.</returns>
        public static UserRole GetTestUserRole(
            int userId, 
            int accountRoleId)
        {
            return new UserRole
            {
                UserId = userId,
                AccountRoleId = accountRoleId
            };
        }

        private static T IntToEnum<T>(int value)
        {
            Array enumValues = Enum.GetValues(typeof(T));
            int ordinal = (value - 1) % enumValues.Length;
            return (T)enumValues.GetValue(ordinal);
        }
    }
}