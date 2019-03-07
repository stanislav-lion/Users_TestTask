namespace Users.DataAccess.Repository
{
    using System;

    /// <summary>
    ///     Repository context.
    /// </summary>
    public interface IRepositoryContext : IDisposable
    {
        /// <summary>
        ///     Gets account address repository.
        /// </summary>
        IAccountAddressRepository AccountAddressRepository { get; }

        /// <summary>
        ///     Gets account repository.
        /// </summary>
        IAccountRepository AccountRepository { get; }

        /// <summary>
        ///     Gets account role repository.
        /// </summary>
        IAccountRoleRepository AccountRoleRepository { get; }

        /// <summary>
        ///     Gets user repository.
        /// </summary>
        IUserRepository UserRepository { get; }

        /// <summary>
        ///     Gets user role repository.
        /// </summary>
        IUserRoleRepository UserRoleRepository { get; }

        /// <summary>
        ///     Gets service broker repository.
        /// </summary>
        // IServiceBrokerRepository ServiceBrokerRepository { get; }

        /// <summary>
        ///     Begins changes.
        /// </summary>
        void BeginChanges();

        /// <summary>
        ///     Saves changes.
        /// </summary>
        void SaveChanges();

        /// <summary>
        ///     Cancel changes.
        /// </summary>
        void CancelChanges();

        /// <summary>
        ///     Performs changes.
        /// </summary>
        /// <param name="changes">Changes to perform.</param>
        void PerformChanges(Func<bool> changes);
    }
}