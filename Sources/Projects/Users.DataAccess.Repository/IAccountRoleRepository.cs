namespace Users.DataAccess.Repository
{
    using System;
    using System.Collections.Generic;
    using Users.DataAccess.DataModel.Types;

    /// <summary>
    ///     Account role repository.
    /// </summary>
    public interface IAccountRoleRepository
    {
        /// <summary>
        ///     Gets account role by identifier.
        /// </summary>
        /// <param name="accountRoleId">The role identifier of account.</param>
        /// <returns></returns>
        AccountRole Get(int accountRoleId);

        /// <summary>
        ///     Gets account role by unique identifier.
        /// </summary>
        /// <param name="accountRoleGuid">The role unique identifier of account.</param>
        /// <returns></returns>
        AccountRole Get(Guid accountRoleGuid);

        /// <summary>
        ///     Gets account roles by account identifier.
        /// </summary>
        /// <param name="accountId">The identifier of account.</param>
        /// <returns>The list of account role.</returns>
        List<AccountRole> GetByAccount(int accountId);

        /// <summary>
        ///     Gets account role identifier by account role unique identifier.
        /// </summary>
        /// <param name="accountRoleGuid">The role unique identifier of account.</param>
        /// <returns>The role identifier of account.</returns>
        int? GetId(Guid accountRoleGuid);

        /// <summary>
        ///     Gets account role identifier by account identifier and role name.
        /// </summary>
        /// <param name="accountId">The identifier of account.</param>
        /// <param name="roleName">The role name.</param>
        /// <returns>The role identifier of account.</returns>
        int? GetId(int accountId, string roleName);

        /// <summary>
        ///     Adds or updates account role.
        /// </summary>
        /// <param name="accountRole">The role of account.</param>
        void Upsert(AccountRole accountRole);

        /// <summary>
        ///     Deletes account role by account role identifier.
        /// </summary>
        /// <param name="accountRoleId">The role identifier of account.</param>
        void Delete(int accountRoleId);

        /// <summary>
        ///     Deletes account roles by account identifier.
        /// </summary>
        /// <param name="accountId">The identifier of account.</param>
        void DeleteByAccount(int accountId);
    }
}