namespace Users.DataAccess.Database.Repositories
{
    using System;
    using System.Runtime.ExceptionServices;
    using Microsoft.EntityFrameworkCore;
    using Users.DataAccess.Database;
    using Users.DataAccess.Database.Common;
    using Users.DataAccess.Repository;

    /// <inheritdoc />
    public sealed class RepositoryContext : IRepositoryContext
    {
        private readonly string[] _connectionStrings;
        private readonly DbContext[] _dbContexts;

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
                "Data Source=localhost;Initial Catalog=ABDB;Integrated Security=True;")
        {
            
        }

        /// <summary>
        ///     Initializes a new instance of the <see cref="RepositoryContext" /> class.
        /// </summary>
        /// <param name="abDbConnectionString">abDbConnectionString</param>
        public RepositoryContext(
            string abDbConnectionString)
        {
            if (string.IsNullOrWhiteSpace(abDbConnectionString))
            {
                throw new ArgumentNullException(nameof(abDbConnectionString));
            }

            _connectionStrings = new[]
            {
                abDbConnectionString
            };

            _dbContexts = new DbContext[_connectionStrings.Length];

            _accountAddressRepository =
                new Lazy<AccountAddressRepository>(
                    () => new AccountAddressRepository(GetDbContext(DatabaseType.DbPrimary)));

            _accountRepository =
                new Lazy<AccountRepository>(() => new AccountRepository(GetDbContext(DatabaseType.DbPrimary)));

            _accountRoleRepository =
                new Lazy<AccountRoleRepository>(
                    () => new AccountRoleRepository(GetDbContext(DatabaseType.DbPrimary)));

            _userRepository =
                new Lazy<UserRepository>(() => new UserRepository(GetDbContext(DatabaseType.DbPrimary)));

            _userRoleRepository =
                new Lazy<UserRoleRepository>(() => new UserRoleRepository(GetDbContext(DatabaseType.DbPrimary)));

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
                foreach (DbContext dbContext in _dbContexts)
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
                foreach (DbContext dbContext in _dbContexts)
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
                foreach (DbContext dbContext in _dbContexts)
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

        private DbContext GetDbContext(DatabaseType databaseType)
        {
            return _dbContexts[(int) databaseType];
        }

        private void Dispose(bool disposing)
        {
            if (_disposed)
            {
                return;
            }

            if (disposing)
            {
                for (var i = 0; i < _dbContexts.Length; i++)
                {
                    if (_dbContexts[i] != null)
                    {
                        _dbContexts[i].Dispose();
                        _dbContexts[i] = null;
                    }
                }
            }

            _disposed = true;
        }
    }
}