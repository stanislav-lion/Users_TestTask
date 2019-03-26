namespace Users.DataAccess.Repository.Async
{
    using System;
    using System.Linq;
    using System.Threading.Tasks;
    using Users.DataAccess.DataModel.Types;

    /// <summary>
    ///     Account role repository.
    /// </summary>
    public interface IAccountRoleRepositoryAsync
    {
        /// <summary>
        ///     Gets all account roles.
        /// </summary>
        Task<IQueryable<AccountRole>> AccountRolesAsync { get; }

        /// <summary>
        ///     Gets account role by identifier.
        /// </summary>
        /// <param name="accountRoleId">The role identifier of account.</param>
        /// <returns>The account role.</returns>
        Task<AccountRole> GetAsync(int accountRoleId);

        /// <summary>
        ///     Gets account role by unique identifier.
        /// </summary>
        /// <param name="accountRoleGuid">The role unique identifier of account.</param>
        /// <returns>The account role.</returns>
        Task<AccountRole> GetAsync(Guid accountRoleGuid);

        /// <summary>
        ///     Gets account roles by account identifier.
        /// </summary>
        /// <param name="accountId">The identifier of account.</param>
        /// <returns>The account role.</returns>
        Task<AccountRole> GetByAccountAsync(int accountId);

        /// <summary>
        ///     Gets account role identifier by account role unique identifier.
        /// </summary>
        /// <param name="accountRoleGuid">The role unique identifier of account.</param>
        /// <returns>The role identifier of account.</returns>
        Task<int?> GetIdAsync(Guid accountRoleGuid);

        /// <summary>
        ///     Gets account role identifier by account identifier and role name.
        /// </summary>
        /// <param name="accountId">The identifier of account.</param>
        /// <param name="roleName">The role name.</param>
        /// <returns>The role identifier of account.</returns>
        Task<int?> GetIdAsync(int accountId, string roleName);

        /// <summary>
        ///     Adds or updates account role.
        /// </summary>
        /// <param name="accountRole">The role of account.</param>
        /// <returns>The number of state entries written to the database.</returns>
        Task<int> UpsertAsync(AccountRole accountRole);

        /// <summary>
        ///     Deletes account role by account role identifier.
        /// </summary>
        /// <param name="accountRoleId">The role identifier of account.</param>
        /// <returns>The number of state entries written to the database.</returns>
        Task<int> DeleteAsync(int accountRoleId);

        /// <summary>
        ///     Deletes account roles by account identifier.
        /// </summary>
        /// <param name="accountId">The identifier of account.</param>
        /// <returns>The number of state entries written to the database.</returns>
        Task<int> DeleteByAccountAsync(int accountId);
    }
}