namespace Users.DataAccess.Repository
{
    using System;
    using System.Linq;
    using Users.DataAccess.DataModel.Types;

    /// <summary>
    ///     Account repository.
    /// </summary>
    public interface IAccountRepository
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
        Account Get(int accountId);

        /// <summary>
        ///     Gets account by unique identifier.
        /// </summary>
        /// <param name="accountGuid">The unique identifier of account.</param>
        /// <returns>The account.</returns>
        Account Get(Guid accountGuid);

        /// <summary>
        ///     Gets account identifier by account unique identifier.
        /// </summary>
        /// <param name="accountGuid">The unique identifier of account.</param>
        /// <returns>The identifier of account.</returns>
        int? GetId(Guid accountGuid);

        /// <summary>
        ///     Gets account identifier by account number.
        /// </summary>
        /// <param name="accountNumber">The number of account.</param>
        /// <returns>The identifier of account.</returns>
        int? GetId(string accountNumber);

        /// <summary>
        ///     Adds or updates account.
        /// </summary>
        /// <param name="account">The account.</param>
        int Upsert(Account account);

        /// <summary>
        ///     Deletes account.
        /// </summary>
        /// <param name="accountId">The identifier of account.</param>
        int Delete(int accountId);
    }
}