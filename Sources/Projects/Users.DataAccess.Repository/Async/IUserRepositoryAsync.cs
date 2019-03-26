namespace Users.DataAccess.Repository.Async
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Users.DataAccess.DataModel.Types;

    /// <summary>
    ///     User repository.
    /// </summary>
    public interface IUserRepositoryAsync
    {
        /// <summary>
        ///     Gets all users.
        /// </summary>
        Task<IQueryable<User>> UsersAsync { get; }

        /// <summary>
        ///     Gets all users without passwords.
        /// </summary>
        Task<IQueryable<User>> UsersWithoutPasswordsAsync { get; }

        /// <summary>
        ///     Gets user by identifier.
        /// </summary>
        /// <param name="userId">User identifier.</param>
        /// <returns></returns>
        Task<User> GetAsync(int userId);

        /// <summary>
        ///     Gets user by unique identifier.
        /// </summary>
        /// <param name="userGuid">The unique identifier of user.</param>
        /// <returns>The user.</returns>
        Task<User> GetAsync(Guid userGuid);

        /// <summary>
        ///     Gets user by logon name.
        /// </summary>
        /// <param name="logonName">The logon name.</param>
        /// <returns>The user.</returns>
        Task<User> GetAsync(string logonName);

        /// <summary>
        ///     Gets users by account identifier.
        /// </summary>
        /// <param name="accountId">The identifier of account.</param>
        /// <returns>The list of users.</returns>
        Task<List<User>> GetByAccountAsync(int accountId);

        /// <summary>
        ///     Gets user identifier by unique identifier.
        /// </summary>
        /// <param name="userGuid">The unique identifier of user.</param>
        /// <returns>The user identifier.</returns>
        Task<int?> GetIdAsync(Guid userGuid);

        /// <summary>
        ///     Adds or updates user.
        /// </summary>
        /// <param name="user">The user.</param>
        /// <returns>The number of state entries written to the database.</returns>
        Task<int> UpsertAsync(User user);

        /// <summary>
        ///     Deletes user by user identifier.
        /// </summary>
        /// <param name="userId">The user identifier.</param>
        /// <returns>The number of state entries written to the database.</returns>
        Task<int> DeleteAsync(int userId);

        /// <summary>
        ///     Deletes user by account identifier.
        /// </summary>
        /// <param name="accountId">>The account identifier.</param>
        /// <returns>The number of state entries written to the database.</returns>
        Task<int> DeleteByAccountAsync(int accountId);
    }
}