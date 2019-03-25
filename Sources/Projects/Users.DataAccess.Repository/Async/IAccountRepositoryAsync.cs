namespace Users.DataAccess.Repository.Async
{
    using System;
    using System.Linq;
    using System.Threading.Tasks;
    using Users.DataAccess.DataModel.Types;

    /// <summary>
    ///     Account repository.
    /// </summary>
    public interface IAccountRepositoryAsync
    {
        /// <summary>
        ///     Gets all accounts.
        /// </summary>
        IQueryable<Account> Accounts { get; }

        /// <summary>
        ///     Gets account bu identifier.
        /// </summary>
        /// <param name="accountId">The identifier of account.</param>
        /// <returns>The account.</returns>
        Task<Account> GetAsync(int accountId);

        /// <summary>
        ///     Gets account by unique identifier.
        /// </summary>
        /// <param name="accountGuid">The unique identifier of account.</param>
        /// <returns>The account.</returns>
        Task<Account> GetAsync(Guid accountGuid);

        /// <summary>
        ///     Gets account identifier by account unique identifier.
        /// </summary>
        /// <param name="accountGuid">The unique identifier of account.</param>
        /// <returns>The identifier of account.</returns>
        Task<int?> GetIdAsync(Guid accountGuid);

        /// <summary>
        ///     Gets account identifier by account number.
        /// </summary>
        /// <param name="accountNumber">The number of account.</param>
        /// <returns>The identifier of account.</returns>
        Task<int?> GetIdAsync(string accountNumber);

        /// <summary>
        ///     Adds or updates account.
        /// </summary>
        /// <param name="account">The account.</param>
        /// <returns>The number of state entries written to the database.</returns>
        Task<int> UpsertAsync(Account account);

        /// <summary>
        ///     Deletes account.
        /// </summary>
        /// <param name="accountId">The identifier of account.</param>
        /// <returns>The number of state entries written to the database.</returns>
        Task<int> DeleteAsync(int accountId);
    }
}