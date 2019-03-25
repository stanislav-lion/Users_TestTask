namespace Users.DataAccess.Repository.Async
{
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Users.DataAccess.DataModel.Types;
    
    /// <summary>
    ///     User role repository.
    /// </summary>
    public interface IUserRoleRepositoryAsync
    {
        /// <summary>
        ///     Gets all user roles.
        /// </summary>
        IQueryable<UserRole> UserRoles { get; }

        /// <summary>
        ///     Gets user role by user identifier and account role identifier.
        /// </summary>
        /// <param name="userId">The identifier of user.</param>
        /// <param name="accountRoleId">The role identifier of account.</param>
        /// <returns>The user role</returns>
        Task<UserRole> GetAsync(int userId, int accountRoleId);

        /// <summary>
        ///     Gets user roles by user identifier.
        /// </summary>
        /// <param name="userId">The user identifier.</param>
        /// <returns>The list of user roles.</returns>
        Task<List<UserRole>> GetAsync(int userId);

        /// <summary>
        ///     Adds user role.
        /// </summary>
        /// <param name="userRole">Thr role of user.</param>
        /// <returns>The number of state entries written to the database.</returns>
        Task<int> AddAsync(UserRole userRole);

        /// <summary>
        ///     Deletes user roles by user identifier.
        /// </summary>
        /// <param name="userId">The identifier of user.</param>
        /// <returns>The number of state entries written to the database.</returns>
        Task<int> DeleteAsync(int userId);

        /// <summary>
        ///     Deletes user role by user identifier and account role identifier.
        /// </summary>
        /// <param name="userId">The identifier of user.</param>
        /// <param name="accountRoleId">The role identifier of account.</param>
        /// <returns>The number of state entries written to the database.</returns>
        Task<int> DeleteAsync(int userId, int accountRoleId);
    }
}