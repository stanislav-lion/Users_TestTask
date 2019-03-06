namespace Users.DataAccess.Repository
{
    using System.Collections.Generic;
    using Users.DataAccess.DataModel.Types;

    /// <summary>
    ///     User role repository.
    /// </summary>
    public interface IUserRoleRepository
    {
        /// <summary>
        ///     Gets user role by user identifier and account role identifier.
        /// </summary>
        /// <param name="userId">The identifier of user.</param>
        /// <param name="accountRoleId">The role identifier of account.</param>
        /// <returns>The user role</returns>
        UserRole Get(int userId, int accountRoleId);

        /// <summary>
        ///     Gets user roles by user identifier.
        /// </summary>
        /// <param name="userId">The user identifier.</param>
        /// <returns>The list of user roles.</returns>
        List<UserRole> Get(int userId);

        /// <summary>
        ///     Adds user role.
        /// </summary>
        /// <param name="userRole">Thr role of user.</param>
        void Add(UserRole userRole);

        /// <summary>
        ///     Deletes user roles by user identifier.
        /// </summary>
        /// <param name="userId">The identifier of user.</param>
        void Delete(int userId);

        /// <summary>
        ///     Deletes user role by user identifier and account role identifier.
        /// </summary>
        /// <param name="userId">The identifier of user.</param>
        /// <param name="accountRoleId">The role identifier of account.</param>
        void Delete(int userId, int accountRoleId);
    }
}