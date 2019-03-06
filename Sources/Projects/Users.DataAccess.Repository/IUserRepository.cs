namespace Users.DataAccess.Repository
{
    using System;
    using System.Collections.Generic;
    using Users.DataAccess.DataModel.Types;

    /// <summary>
    ///     User repository.
    /// </summary>
    public interface IUserRepository
    {
        /// <summary>
        ///     Gets user by identifier.
        /// </summary>
        /// <param name="userId">User identifier.</param>
        /// <returns></returns>
        User Get(int userId);

        /// <summary>
        ///     Gets user by unique identifier.
        /// </summary>
        /// <param name="userGuid">The unique identifier of user.</param>
        /// <returns>The user.</returns>
        User Get(Guid userGuid);

        /// <summary>
        ///     Gets user by logon name.
        /// </summary>
        /// <param name="logonName">The logon name.</param>
        /// <returns>The user.</returns>
        User Get(string logonName);

        /// <summary>
        ///     Gets users by account identifier.
        /// </summary>
        /// <param name="accountId">The identifier of account.</param>
        /// <returns>The list of users.</returns>
        List<User> GetByAccount(int accountId);

        /// <summary>
        ///     Gets user identifier by unique identifier.
        /// </summary>
        /// <param name="userGuid">The unique identifier of user.</param>
        /// <returns>The user identifier.</returns>
        int? GetId(Guid userGuid);

        /// <summary>
        ///     Adds or updates user.
        /// </summary>
        /// <param name="user">The user.</param>
        void Upsert(User user);

        /// <summary>
        ///     Deletes user by user identifier.
        /// </summary>
        /// <param name="userId">The user identifier.</param>
        void Delete(int userId);

        /// <summary>
        ///     Deletes user by account identifier.
        /// </summary>
        /// <param name="accountId">>The account identifier.</param>
        void DeleteByAccount(int accountId);
    }
}