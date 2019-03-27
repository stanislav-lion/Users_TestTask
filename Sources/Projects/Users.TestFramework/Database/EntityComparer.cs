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
        ///     Compare users.
        /// </summary>
        /// <param name="user1">User1.</param>
        /// <param name="user2">User2.</param>
        /// <returns>Bool.</returns>
        public static bool AreUserEqual(User user1, User user2)
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
        public static bool AreUserRoleEqual(UserRole userRole1, UserRole userRole2)
        {
            return userRole1.UserId == userRole2.UserId &&
                   userRole1.AccountRoleId == userRole2.AccountRoleId;
        }

        private static bool AreDateTimeEqual(DateTime? dateTime1, DateTime? dateTime2)
        {
            if (dateTime1.HasValue && dateTime2.HasValue)
            {
                return Math.Abs((dateTime1.Value - dateTime2.Value).TotalSeconds) < 0.01;
            }

            return false;
        }
    }
}