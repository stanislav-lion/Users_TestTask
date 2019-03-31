namespace Users.DataAccess.Database.Contexts
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.Common;
    using Microsoft.EntityFrameworkCore;
    using Users.DataAccess.Database.Interfaces;
    using Users.DataAccess.DataModel.Enums;
    using Users.DataAccess.DataModel.EventArgs;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Database.Common;
    using System.Runtime.ExceptionServices;
    using System.Linq;

    /// <inheritdoc cref="DbContext" />
    public class UserContext : DbContext, IDbContext
    {
        private readonly IConnectionStringPrioritizer _connectionStringPrioritizer;
        private readonly IStoredProcedurePrioritizer _storedProcedurePrioritizer;

        private DbConnection _connection;
        private DbTransaction _transaction;
        private int _transactionCount;

        private bool _disposed;

        /// <summary>
        ///     Initializes a new instance of the <see cref="UserContext"/> class.
        /// </summary>
        /// <param name="options">Database context options.</param>
        public UserContext(DbContextOptions<UserContext> options)
            : base(options)
        {
            _connectionStringPrioritizer = new DefaultConnectionStringPrioritizer();
            _storedProcedurePrioritizer = new DefaultStoredProcedurePrioritizer();

            _connection = null;
            _transaction = null;
            _transactionCount = 0;

            _disposed = false;
        }
        
        /// <summary>
        ///     Finalizes an instance of the <see cref="UserContext"/> class.
        /// </summary>
        ~UserContext()
        {
            Dispose(false);
        }

        /// <summary>
        ///     Database table Account.
        /// </summary>
        public DbSet<Account> Account { get; set; }

        /// <summary>
        ///     Database table AccountRole.
        /// </summary>
        public DbSet<AccountRole> AccountRole { get; set; }

        /// <summary>
        ///     Database table AccountAddress.
        /// </summary>
        public DbSet<AccountAddress> AccountAddress { get; set; }

        /// <summary>
        ///     Database table User.
        /// </summary>
        public DbSet<User> User { get; set; }

        /// <summary>
        ///     Database table UserRole.
        /// </summary>
        public DbSet<UserRole> UserRole { get; set; }

        /// <summary>
        ///     Event that is triggered when stored procedure runs too long.
        /// </summary>
        public event EventHandler<LongRunningStoredProcedureEventArgs> OnLongRunningStoredProcedure;

        /// <inheritdoc />
        public override void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        /// <inheritdoc />
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Account>()
                .Property(account => account.AccountNumber)
                .IsRequired()
                .HasMaxLength(8);

            modelBuilder.Entity<Account>()
                .Property(account => account.AccountName)
                .IsRequired()
                .HasMaxLength(50);


            modelBuilder.Entity<AccountRole>()
                .Property(accountRole => accountRole.RoleName)
                .IsRequired()
                .HasMaxLength(40);

            modelBuilder
                .Entity<AccountRole>()
                .Property(accountRole => accountRole.RoleType)
                .HasConversion(
                    value => (int)value,
                    value => (RoleType)value);

            modelBuilder
                .Entity<AccountRole>()
                .Property(accountRole => accountRole.PrivilegeType)
                .HasConversion(
                    value => (byte)value,
                    value => (PrivilegeType)value);


            modelBuilder.Entity<AccountAddress>()
                .HasKey(accountAddress => accountAddress.AccountId);

            modelBuilder
                .Entity<AccountAddress>()
                .Property(accountAddress => accountAddress.AddressType)
                .HasConversion(
                    value => (int)value,
                    value => (AddressType)value);

            modelBuilder.Entity<AccountAddress>()
                .Property(accountAddress => accountAddress.AddressLine1)
                .HasMaxLength(100);

            modelBuilder.Entity<AccountAddress>()
                .Property(accountAddress => accountAddress.AddressLine2)
                .HasMaxLength(100);

            modelBuilder.Entity<AccountAddress>()
                .Property(accountAddress => accountAddress.AddressLine3)
                .HasMaxLength(100);

            modelBuilder.Entity<AccountAddress>()
                .Property(accountAddress => accountAddress.City)
                .IsRequired()
                .HasMaxLength(50);

            modelBuilder.Entity<AccountAddress>()
                .Property(accountAddress => accountAddress.County)
                .IsRequired()
                .HasMaxLength(50);

            modelBuilder.Entity<AccountAddress>()
                .Property(accountAddress => accountAddress.StateProvince)
                .HasMaxLength(50);

            modelBuilder.Entity<AccountAddress>()
                .Property(accountAddress => accountAddress.PostalCode)
                .HasMaxLength(15);

            modelBuilder.Entity<AccountAddress>()
                .Property(accountAddress => accountAddress.CountryTwoLetterCode)
                .IsRequired()
                .HasMaxLength(2);


            modelBuilder.Entity<User>()
                .Property(user => user.LogonName)
                .IsRequired()
                .HasMaxLength(100);

            modelBuilder.Entity<User>()
                .Property(user => user.FirstName)
                .IsRequired()
                .HasMaxLength(50);

            modelBuilder.Entity<User>()
                .Property(user => user.LastName)
                .IsRequired()
                .HasMaxLength(100);

            modelBuilder.Entity<User>()
                .Property(user => user.MiddleName)
                .HasMaxLength(30);

            modelBuilder.Entity<User>()
                .Property(user => user.PasswordSalt)
                .IsRequired()
                .HasMaxLength(30);

            modelBuilder.Entity<User>()
                .Property(user => user.PasswordHash)
                .IsRequired()
                .HasMaxLength(30);

            modelBuilder.Entity<User>()
                .Property(user => user.CultureCode)
                .IsRequired()
                .HasMaxLength(10);


            modelBuilder.Entity<UserRole>()
                .HasKey(userRole => userRole.UserId);
        }

        /// <inheritdoc />
        public void BeginTransaction()
        {
            //Database.BeginTransaction();

            if (_transaction == null)
            {
                CreateConnection(null);

                if (_connection.State != ConnectionState.Open)
                {
                    _connection.Open();
                }

                _transaction = _connection.BeginTransaction();
            }

            _transactionCount++;
        }

        /// <inheritdoc />
        public void CommitTransaction()
        {
            //Database.CommitTransaction();

            if (_transactionCount > 0)
            {
                _transactionCount--;
            }

            if (_transaction != null && _transactionCount == 0)
            {
                try
                {
                    _transaction.Commit();
                }
                finally
                {
                    DisposeConnection();
                }
            }
        }

        /// <inheritdoc />
        public void RollbackTransaction()
        {
            //Database.RollbackTransaction();

            _transactionCount = 0;

            if (_transaction != null)
            {
                try
                {
                    _transaction.Rollback();
                }
                catch (InvalidOperationException)
                {
                    // Rollback generates InvalidOperationException if the connection is broken
                    // or the transaction has already been committed or rolled back on the server
                }
                finally
                {
                    DisposeConnection();
                }
            }
        }

        /// <inheritdoc />
        public bool InTransaction()
        {
            return (_transaction != null);
        }

        /// <inheritdoc />
        public void ExecuteStoredProcedureNoResult(
            string storedProcedureName, 
            DbParameter[] parameters)
        {
            if (string.IsNullOrWhiteSpace(storedProcedureName))
            {
                throw new ArgumentNullException(nameof(storedProcedureName));
            }

            ExecuteCommand(
                storedProcedureName,
                parameters,
                command =>
                {
                    command.ExecuteNonQuery();
                },
                true);
        }

        /// <inheritdoc />
        public TEntity GetEntity<TEntity>(
            string storedProcedureName,
            DbParameter[] parameters,
            Func<IDataRecord, TEntity> buildEntity)
        {
            if (string.IsNullOrWhiteSpace(storedProcedureName))
            {
                throw new ArgumentNullException(nameof(storedProcedureName));
            }

            return GetEntities(storedProcedureName, parameters, buildEntity)
                .SingleOrDefault();
        }

        /// <inheritdoc />
        public List<TEntity> GetEntities<TEntity>(
            string storedProcedureName, 
            DbParameter[] parameters, 
            Func<IDataRecord, TEntity> buildEntity)
        {
            if (string.IsNullOrWhiteSpace(storedProcedureName))
            {
                throw new ArgumentNullException(nameof(storedProcedureName));
            }

            try
            {
                using (DbDataReader reader = ExecuteStoredProcedureReader(storedProcedureName, parameters))
                {
                    var entities = new List<TEntity>();
                    while (reader.Read())
                    {
                        entities.Add(buildEntity(reader));
                    }

                    return entities;
                }
            }
            finally
            {
                if (!InTransaction())
                {
                    DisposeConnection();
                }
            }
        }

        private void Dispose(bool disposing)
        {
            if (_disposed)
            {
                return;
            }

            if (disposing)
            {
                DisposeConnection();
            }

            _disposed = true;
        }

        private void DisposeConnection()
        {
            if (_transaction != null)
            {
                _transaction.Dispose();
                _transaction = null;
            }

            if (_connection != null)
            {
                _connection.Dispose();
                _connection = null;
            }
        }

        private void CreateConnection(string connectionString)
        {
            throw new NotImplementedException();
        }

        private void ExecuteCommand(
            string storedProcedureName,
            DbParameter[] parameters,
            Action<DbCommand> action,
            bool closeConnection)
        {
            void InternalAction()
            {
                DbCommand command = CreateCommand(storedProcedureName, parameters);

                try
                {
                    if (_connection.State != ConnectionState.Open)
                    {
                        _connection.Open();
                    }

                    DateTime startUtc = DateTime.UtcNow;
                    action.Invoke(command);
                    var executionTimeSeconds = (int)DateTime.UtcNow.Subtract(startUtc).TotalSeconds;

                    if (executionTimeSeconds >= Settings.Instance.DBContextSetting.LongRunningStoredProcedureTimeSeconds)
                    {
                        OnLongRunningStoredProcedure?.Invoke(
                            this,
                            new LongRunningStoredProcedureEventArgs(storedProcedureName, executionTimeSeconds));
                    }
                }
                catch (Exception exception)
                {
                    //DbConnection.ClearPool(_connection);
                    ExceptionDispatchInfo.Capture(exception).Throw();
                }
                finally
                {
                    if (!InTransaction() && closeConnection)
                    {
                        DisposeConnection();
                    }
                }
            }

            if (InTransaction())
            {
                InternalAction();
            }
            else
            {
                Retrier.InvokeAction(
                    InternalAction,
                    Settings.Instance.DBContextSetting.RetriesNumber,
                    Settings.Instance.DBContextSetting.SleepBetweenRetriesMilliSeconds,
                    RetrierHelper.IsRetriableError);
            }
        }

        private DbDataReader ExecuteStoredProcedureReader(
            string storedProcedureName, 
            DbParameter[] parameters)
        {
            DbDataReader sqlDataReader = null;

            ExecuteCommand(
                storedProcedureName,
                parameters,
                command =>
                {
                    sqlDataReader =
                        command.ExecuteReader(
                            InTransaction() 
                                ? CommandBehavior.Default 
                                : CommandBehavior.CloseConnection);
                },
                false);

            return sqlDataReader;
        }

        private DbCommand CreateCommand(
            string storedProcedureName,
            DbParameter[] parameters)
        {
            throw new NotImplementedException();
        }
    }
}