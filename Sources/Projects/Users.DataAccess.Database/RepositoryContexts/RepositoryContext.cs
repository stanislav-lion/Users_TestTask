namespace Users.DataAccess.Database.RepositoryContexts
{
    using System;
    using System.Runtime.ExceptionServices;
    using Users.DataAccess.Database;
    using Users.DataAccess.Database.Common;
    using Users.DataAccess.Database.Contexts;
    using Users.DataAccess.Database.Repositories;
    using Users.DataAccess.DataModel.EventArgs;
    using Users.DataAccess.Repository;

    /// <inheritdoc cref="IRepositoryContext" />
    public sealed class RepositoryContext : IRepositoryContext
    {
        private readonly UserContext[] _userContexts;

        private readonly string[] _connectionStrings;

        private readonly Lazy<AccountRepository> _accountRepository;
        private readonly Lazy<AccountRoleRepository> _accountRoleRepository;
        private readonly Lazy<AccountAddressRepository> _accountAddressRepository;
        private readonly Lazy<UserRepository> _userRepository;
        private readonly Lazy<UserRoleRepository> _userRoleRepository;

        //private readonly Lazy<ServiceBrokerRepository> _serviceBrokerRepository;

        private int _changesCount;
        private bool _disposed;
        private bool _inChanges;

        /// <summary>
        ///     Initializes a new instance of the <see cref="RepositoryContext" /> class.
        /// </summary>
        public RepositoryContext()
            : this(Resource.DefaultConnectionString)
        {

        }

        /// <summary>
        ///     Initializes a new instance of the <see cref="RepositoryContext" /> class.
        /// </summary>
        /// <param name="dbConnectionString">DbConnectionString.</param>
        public RepositoryContext(string dbConnectionString)
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

            _accountRepository =
                new Lazy<AccountRepository>(() => new AccountRepository(GetUserContext(DBType.DbPrimary)));

            _accountRoleRepository =
                new Lazy<AccountRoleRepository>(
                    () => new AccountRoleRepository(GetUserContext(DBType.DbPrimary)));

            _accountAddressRepository =
                new Lazy<AccountAddressRepository>(
                    () => new AccountAddressRepository(GetUserContext(DBType.DbPrimary)));

            _userRepository =
                new Lazy<UserRepository>(() => new UserRepository(GetUserContext(DBType.DbPrimary)));

            _userRoleRepository =
                new Lazy<UserRoleRepository>(() => new UserRoleRepository(GetUserContext(DBType.DbPrimary)));

            //_serviceBrokerRepository =
            //    new Lazy<ServiceBrokerRepository>(
            //        () => new ServiceBrokerRepository(GetDbContext(DatabaseType.DbMsg)));

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

        /// <summary>
        ///     Event that is triggered when stored procedure runs too long.
        /// </summary>
        public event EventHandler<LongRunningStoredProcedureEventArgs> OnLongRunningStoredProcedure;

        /// <inheritdoc />
        public IAccountRepository AccountRepository => _accountRepository.Value;

        /// <inheritdoc />
        public IAccountRoleRepository AccountRoleRepository => _accountRoleRepository.Value;

        /// <inheritdoc />
        public IAccountAddressRepository AccountAddressRepository => _accountAddressRepository.Value;
        
        /// <inheritdoc />
        public IUserRepository UserRepository => _userRepository.Value;

        /// <inheritdoc />
        public IUserRoleRepository UserRoleRepository => _userRoleRepository.Value;

        /// <inheritdoc />
        //public IServiceBrokerRepository ServiceBrokerRepository => _serviceBrokerRepository.Value;

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
                foreach (UserContext userContext in _userContexts)
                {
                    userContext?.BeginTransaction();
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
                foreach (UserContext userContext in _userContexts)
                {
                    userContext?.CommitTransaction();
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
                foreach (UserContext userContext in _userContexts)
                {
                    userContext?.RollbackTransaction();
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
                Settings.DBContextSetting.RetriesNumber,
                Settings.DBContextSetting.SleepBetweenRetriesMilliSeconds,
                RetrierHelper.IsRetriableError);
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

        private UserContext GetUserContext(DBType dbType)
        {
            var dbOrdinal = (int)dbType;

            if (_userContexts[dbOrdinal] == null)
            {
                var userContext = _userContexts[(int) dbType];

                userContext.OnLongRunningStoredProcedure += (s, e) => OnLongRunningStoredProcedure?.Invoke(
                    this,
                    new LongRunningStoredProcedureEventArgs(e.StoredProcedureName, e.ExecutionTimeSeconds));

                _userContexts[dbOrdinal] = userContext;

                if (_inChanges)
                {
                    _userContexts[dbOrdinal]?.Database.BeginTransaction();
                }
            }

            return _userContexts[dbOrdinal];
        }
    }
}