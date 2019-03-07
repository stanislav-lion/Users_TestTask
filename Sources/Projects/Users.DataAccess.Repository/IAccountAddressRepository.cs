namespace Users.DataAccess.Repository
{
    using System.Linq;
    using Users.DataAccess.DataModel.Types;

    /// <summary>
    ///     Account address repository.
    /// </summary>
    public interface IAccountAddressRepository
    {
        /// <summary>
        ///     Gets all account adresses.
        /// </summary>
        IQueryable<AccountAddress> AccountAddresses { get; }

        /// <summary>
        ///     Gets account address.
        /// </summary>
        /// <param name="accountId">The identifier of account.</param>
        /// <returns>The address of account.</returns>
        AccountAddress Get(int accountId);

        /// <summary>
        ///     Adds or updates account address.
        /// </summary>
        /// <param name="accountAddress">The address of account.</param>
        void Upsert(AccountAddress accountAddress);
    }
}