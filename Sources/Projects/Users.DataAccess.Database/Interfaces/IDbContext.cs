namespace Users.DataAccess.Database.Interfaces
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.Common;

    /// <summary>
    ///     Defines database context.
    /// </summary>
    internal interface IDbContext
    {
        /// <summary>
        ///     Starts transaction.
        /// </summary>
        void BeginTransaction();

        /// <summary>
        ///     Commits transaction.
        /// </summary>
        void CommitTransaction();

        /// <summary>
        ///     Rolls back transaction.
        /// </summary>
        void RollbackTransaction();

        /// <summary>
        ///     Gets flag indicating whether there is an active transaction.
        /// </summary>
        /// <returns>Flag indicating whether there is an active transaction.</returns>
        bool InTransaction();

        /// <summary>
        ///     Executes stored procedure that does not return result.
        /// </summary>
        /// <param name="storedProcedureName">Stored procedure name.</param>
        /// <param name="parameters">Parameters.</param>
        void ExecuteStoredProcedureNoResult(string storedProcedureName, DbParameter[] parameters);

        /// <summary>
        ///     Executes stored procedure that returns single entity.
        /// </summary>
        /// <typeparam name="TEntity">Type of entity.</typeparam>
        /// <param name="storedProcedureName">Stored procedure name.</param>
        /// <param name="parameters">Parameters.</param>
        /// <param name="buildEntity">Function creates entity from the data record.</param>
        /// <returns>Entity.</returns>
        TEntity GetEntity<TEntity>(
            string storedProcedureName,
            DbParameter[] parameters,
            Func<IDataRecord, TEntity> buildEntity);

        /// <summary>
        ///     Executes stored procedure that returns multiple entities.
        /// </summary>
        /// <typeparam name="TEntity">Type of entity.</typeparam>
        /// <param name="storedProcedureName">Stored procedure name.</param>
        /// <param name="parameters">Parameters.</param>
        /// <param name="buildEntity">Function creates entity from the data record.</param>
        /// <returns>Entities.</returns>
        List<TEntity> GetEntities<TEntity>(
            string storedProcedureName,
            DbParameter[] parameters,
            Func<IDataRecord, TEntity> buildEntity);
    }
}