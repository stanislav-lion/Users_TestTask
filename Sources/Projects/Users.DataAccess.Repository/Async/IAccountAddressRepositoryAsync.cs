namespace Users.DataAccess.Repository.Async
{
    using System.Linq;
    using System.Threading.Tasks;
    using Users.DataAccess.DataModel.Types;

    /// <summary>
    ///     Account address repository.
    /// </summary>
    public interface IAccountAddressRepositoryAsync
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
        Task<AccountAddress> GetAsync(int accountId);

        /// <summary>
        ///     Adds or updates account address.
        /// </summary>
        /// <param name="accountAddress">The address of account.</param>
        /// <returns>The number of state entries written to the database.</returns>
        Task<int> UpsertAsync(AccountAddress accountAddress);
    }
}