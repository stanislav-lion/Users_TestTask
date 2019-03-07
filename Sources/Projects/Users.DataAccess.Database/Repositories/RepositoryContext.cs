namespace Users.DataAccess.Database.Repositories
{
    using System;
    using System.Runtime.ExceptionServices;
    using Microsoft.EntityFrameworkCore;
    using Users.DataAccess.Database;
    using Users.DataAccess.Database.Common;
    using Users.DataAccess.Database.Contexts;
    using Users.DataAccess.Repository;

    /// <inheritdoc />
    public sealed class RepositoryContext : IRepositoryContext
    {
        private readonly string[] _connectionStrings;
        private readonly UserContext[] _userContexts;

        private readonly Lazy<AccountAddressRepository> _accountAddressRepository;
        private readonly Lazy<AccountRepository> _accountRepository;
        private readonly Lazy<AccountRoleRepository> _accountRoleRepository;
        private readonly Lazy<UserRepository> _userRepository;
        private readonly Lazy<UserRoleRepository> _userRoleRepository;

        // private readonly Lazy<ServiceBrokerRepository> _serviceBrokerRepository;

        private int _changesCount;
        private bool _disposed;
        private bool _inChanges;

        /// <summary>
        ///     Initializes a new instance of the <see cref="RepositoryContext" /> class.
        /// </summary>
        public RepositoryContext()
            : this(
                /*Settings.Default.DbConnectionString*/
                "Data Source=localhost;Initial Catalog=Users;Integrated Security=True;")
        {

        }

        /// <summary>
        ///     Initializes a new instance of the <see cref="RepositoryContext" /> class.
        /// </summary>
        /// <param name="dbConnectionString">DbConnectionString.</param>
        public RepositoryContext(
            string dbConnectionString)
        {
            if (string.IsNullOrWhiteSpace(dbConnectionString))
            {
                throw new ArgumentNullException(nameof(dbConnectionString));
            }

            _connectionStrings = new[]
            {
                dbConnectionString
            };

            _userContexts = new UserContext[_connectionStrings.Length];

            _accountAddressRepository =
                new Lazy<AccountAddressRepository>(
                    () => new AccountAddressRepository(GetUserContext(DatabaseType.DbPrimary)));

            _accountRepository =
                new Lazy<AccountRepository>(() => new AccountRepository(GetUserContext(DatabaseType.DbPrimary)));

            _accountRoleRepository =
                new Lazy<AccountRoleRepository>(
                    () => new AccountRoleRepository(GetUserContext(DatabaseType.DbPrimary)));

            _userRepository =
                new Lazy<UserRepository>(() => new UserRepository(GetUserContext(DatabaseType.DbPrimary)));

            _userRoleRepository =
                new Lazy<UserRoleRepository>(() => new UserRoleRepository(GetUserContext(DatabaseType.DbPrimary)));

            /*_serviceBrokerRepository =
                new Lazy<ServiceBrokerRepository>(
                    () => new ServiceBrokerRepository(GetDbContext(DatabaseType.DbMsg)));*/

            _inChanges = false;
            _changesCount = 0;
            _disposed = false;
        }

        /// <summary>
        ///     Finalizes an instance of the <see cref="RepositoryContext" /> class.
        /// </summary>
        ~RepositoryContext()
        {
            Dispose(false);
        }

        /// <inheritdoc />
        public IAccountAddressRepository AccountAddressRepository => _accountAddressRepository.Value;

        /// <inheritdoc />
        public IAccountRepository AccountRepository => _accountRepository.Value;

        /// <inheritdoc />
        public IAccountRoleRepository AccountRoleRepository => _accountRoleRepository.Value;

        /// <inheritdoc />
        public IUserRepository UserRepository => _userRepository.Value;

        /// <inheritdoc />
        public IUserRoleRepository UserRoleRepository => _userRoleRepository.Value;

        /// <inheritdoc />
        // public IServiceBrokerRepository ServiceBrokerRepository => _serviceBrokerRepository.Value;
        
        /// <summary>
        ///     Performs application-defined tasks associated with freeing, releasing, or resetting unmanaged resources.
        /// </summary>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        /// <inheritdoc />
        public void BeginChanges()
        {
            if (!_inChanges)
            {
                foreach (DbContext dbContext in _userContexts)
                {
                    dbContext?.Database.BeginTransaction();
                }

                _inChanges = true;
            }

            _changesCount++;
        }

        /// <inheritdoc />
        public void SaveChanges()
        {
            if (_changesCount > 0)
            {
                _changesCount--;
            }

            if (_inChanges && _changesCount == 0)
            {
                foreach (DbContext dbContext in _userContexts)
                {
                    dbContext?.SaveChanges();
                }

                _inChanges = false;
            }
        }

        /// <inheritdoc />
        public void CancelChanges()
        {
            _changesCount = 0;

            if (_inChanges)
            {
                foreach (DbContext dbContext in _userContexts)
                {
                    dbContext?.Database.RollbackTransaction();
                }

                _inChanges = false;
            }
        }

        /// <inheritdoc />
        public void PerformChanges(Func<bool> changes)
        {
            void InternalAction()
            {
                BeginChanges();

                try
                {
                    if (changes.Invoke())
                    {
                        SaveChanges();
                    }
                    else
                    {
                        CancelChanges();
                    }
                }
                catch (Exception exception)
                {
                    CancelChanges();
                    ExceptionDispatchInfo.Capture(exception).Throw();
                }
            }

            Retrier.InvokeAction(
                InternalAction,
                /*Settings.Default.RetriesNumber*/ 3,
                /*Settings.Default.SleepBetweenRetriesMilliSeconds*/ 3000,
                RetrierHelper.IsRetriableSqlError);
        }

        private void Dispose(bool disposing)
        {
            if (_disposed)
            {
                return;
            }

            if (disposing)
            {
                for (var i = 0; i < _userContexts.Length; i++)
                {
                    if (_userContexts[i] != null)
                    {
                        _userContexts[i].Dispose();
                        _userContexts[i] = null;
                    }
                }
            }

            _disposed = true;
        }

        private UserContext GetUserContext(DatabaseType databaseType)
        {
            return _userContexts[(int) databaseType];
        }
    }
}