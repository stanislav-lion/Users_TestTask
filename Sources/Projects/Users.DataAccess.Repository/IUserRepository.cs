namespace Users.DataAccess.Repository
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using Users.DataAccess.DataModel.Types;

    /// <summary>
    ///     User repository.
    /// </summary>
    public interface IUserRepository
    {
        /// <summary>
        ///     Gets all users.
        /// </summary>
        IQueryable<User> Users { get; }

        /// <summary>
        ///     Gets all users without passwords.
        /// </summary>
        IQueryable<User> UsersWithoutPasswords { get; }

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
        ///     Gets user identifier by logon name.
        /// </summary>
        /// <param name="logonName">Logon name.</param>
        /// <returns>User identifier.</returns>
        int? GetId(string logonName);

        /// <summary>
        ///     Adds or updates user.
        /// </summary>
        /// <param name="user">The user.</param>
        /// <returns>The number of state entries written to the database.</returns>
        int Upsert(User user);

        /// <summary>
        ///     Deletes user by user identifier.
        /// </summary>
        /// <param name="userId">The user identifier.</param>
        /// <returns>The number of state entries written to the database.</returns>
        int Delete(int userId);

        /// <summary>
        ///     Deletes user by account identifier.
        /// </summary>
        /// <param name="accountId">>The account identifier.</param>
        /// <returns>The number of state entries written to the database.</returns>
        int DeleteByAccount(int accountId);
    }
}