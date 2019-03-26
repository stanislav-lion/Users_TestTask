namespace Users.DataAccess.Repository.Async
{
    using System;

    /// <summary>
    ///     Repository context.
    /// </summary>
    public interface IRepositoryContextAsync : IDisposable
    {
        /// <summary>
        ///     Gets account address repository.
        /// </summary>
        IAccountAddressRepositoryAsync AccountAddressRepositoryAsync { get; }

        /// <summary>
        ///     Gets account repository.
        /// </summary>
        IAccountRepositoryAsync AccountRepositoryAsync { get; }

        /// <summary>
        ///     Gets account role repository.
        /// </summary>
        IAccountRoleRepositoryAsync AccountRoleRepositoryAsync { get; }

        /// <summary>
        ///     Gets user repository.
        /// </summary>
        IUserRepositoryAsync UserRepositoryAsync { get; }

        /// <summary>
        ///     Gets user role repository.
        /// </summary>
        IUserRoleRepositoryAsync UserRoleRepositoryAsync { get; }

        /// <summary>
        ///     Gets service broker repository.
        /// </summary>
        //IServiceBrokerRepository ServiceBrokerRepository { get; }

        /// <summary>
        ///     Begins changes.
        /// </summary>
        void BeginChangesAsync();

        /// <summary>
        ///     Saves changes.
        /// </summary>
        void SaveChangesAsync();

        /// <summary>
        ///     Cancel changes.
        /// </summary>
        void CancelChangesAsync();

        /// <summary>
        ///     Performs changes.
        /// </summary>
        /// <param name="changes">Changes to perform.</param>
        void PerformChangesAsync(Func<bool> changes);
    }
}