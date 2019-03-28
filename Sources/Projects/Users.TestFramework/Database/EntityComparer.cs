namespace Users.TestFramework.Database
{
    using System;
    using Users.DataAccess.DataModel.Types;

    /// <summary>
    ///     Helper class used to compare entities.
    /// </summary>
    public static class EntityComparer
    {
        /// <summary>
        ///     Compare accounts.
        /// </summary>
        /// <param name="account1">Account1.</param>
        /// <param name="account2">Account2.</param>
        /// <returns>Bool.</returns>
        public static bool AreAccountEqual(
            Account account1, 
            Account account2)
        {
            return account1.AccountId == account2.AccountId &&
                   account1.AccountGuid == account2.AccountGuid &&
                   account1.AccountNumber == account2.AccountNumber &&
                   account1.AccountName == account2.AccountName &&
                   account1.IsEnabled == account2.IsEnabled &&
                   account1.TimeZone == account2.TimeZone &&
                   account1.PasswordExpirationPeriodInDays == account2.PasswordExpirationPeriodInDays &&
                   account1.DataStorageTimeHrs == account2.DataStorageTimeHrs &&
                   account1.NumberOfCodeManagementApps == account2.NumberOfCodeManagementApps;
        }

        /// <summary>
        ///     Compare account roles.
        /// </summary>
        /// <param name="accountRole1">AccountRole1.</param>
        /// <param name="accountRole2">AccountRole2.</param>
        /// <returns>Bool.</returns>
        public static bool AreAccountRoleEqual(
            AccountRole accountRole1,
            AccountRole accountRole2)
        {
            return accountRole1.AccountRoleId == accountRole2.AccountRoleId &&
                   accountRole1.AccountRoleGuid == accountRole2.AccountRoleGuid &&
                   accountRole1.AccountId == accountRole2.AccountId &&
                   accountRole1.RoleName == accountRole2.RoleName &&
                   accountRole1.RoleType == accountRole2.RoleType &&
                   accountRole1.PrivilegeType == accountRole2.PrivilegeType;
        }

        /// <summary>
        ///     Compare account addresses.
        /// </summary>
        /// <param name="accountAddress1">AccountAddress1</param>
        /// <param name="accountAddress2">AccountAddress2</param>
        /// <returns>Bool.</returns>
        public static bool AreAccountAddressEqual(
            AccountAddress accountAddress1, 
            AccountAddress accountAddress2)
        {
            return accountAddress1.AccountId == accountAddress2.AccountId &&
                   accountAddress1.AddressType == accountAddress2.AddressType &&
                   accountAddress1.AddressLine1 == accountAddress2.AddressLine1 &&
                   accountAddress1.AddressLine2 == accountAddress2.AddressLine2 &&
                   accountAddress1.AddressLine3 == accountAddress2.AddressLine3 &&
                   accountAddress1.City == accountAddress2.City &&
                   accountAddress1.County == accountAddress2.County &&
                   accountAddress1.StateProvince == accountAddress2.StateProvince &&
                   accountAddress1.PostalCode == accountAddress2.PostalCode &&
                   accountAddress1.CountryTwoLetterCode == accountAddress2.CountryTwoLetterCode;
        }

        /// <summary>
        ///     Compare users.
        /// </summary>
        /// <param name="user1">User1.</param>
        /// <param name="user2">User2.</param>
        /// <returns>Bool.</returns>
        public static bool AreUserEqual(
            User user1, 
            User user2)
        {
            return user1.UserId == user2.UserId &&
                   user1.UserGuid == user2.UserGuid &&
                   user1.LogonName == user2.LogonName &&
                   user1.AccountId == user2.AccountId &&
                   user1.FirstName == user2.FirstName &&
                   user1.LastName == user2.LastName &&
                   user1.MiddleName == user2.MiddleName &&
                   user1.PasswordSalt == user2.PasswordSalt &&
                   user1.PasswordHash == user2.PasswordHash &&
                   AreDateTimeEqual(user1?.PasswordChangeUtc, user2?.PasswordChangeUtc) &&
                   user1.PasswordMustBeChanged == user2.PasswordMustBeChanged &&
                   user1.IsLogonEnabled == user2.IsLogonEnabled &&
                   user1.TimeZone == user2.TimeZone &&
                   user1.CultureCode == user2.CultureCode;
        }

        /// <summary>
        ///     Compare user roles.
        /// </summary>
        /// <param name="userRole1">User role1</param>
        /// <param name="userRole2">User role2</param>
        /// <returns>Bool.</returns>
        public static bool AreUserRoleEqual(
            UserRole userRole1, 
            UserRole userRole2)
        {
            return userRole1.UserId == userRole2.UserId &&
                   userRole1.AccountRoleId == userRole2.AccountRoleId;
        }

        private static bool AreDateTimeEqual(
            DateTime? dateTime1, 
            DateTime? dateTime2)
        {
            if (dateTime1.HasValue && dateTime2.HasValue)
            {
                return Math.Abs((dateTime1.Value - dateTime2.Value).TotalSeconds) < 0.01;
            }

            return false;
        }
    }
}