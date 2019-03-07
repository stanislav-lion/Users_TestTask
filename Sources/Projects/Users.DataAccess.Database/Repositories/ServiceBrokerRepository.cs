namespace Users.DataAccess.Database.Repositories
{
    using System;
    using Microsoft.EntityFrameworkCore;
    using Users.DataAccess.Database.BaseRepositories;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository;

    /// <inheritdoc cref="IServiceBrokerRepository" />
    internal sealed class ServiceBrokerRepository : EntityRepository, IServiceBrokerRepository
    {
        /// <summary>
        ///     Initializes a new instance of the <see cref="ServiceBrokerRepository" /> class.
        /// </summary>
        /// <param name="dbContext">Database context.</param>
        public ServiceBrokerRepository(DbContext dbContext)
            : base(dbContext) { }
        
        /// <inheritdoc />
        public Guid BeginDialog(
            string initiatorServiceName, 
            string targetServiceName, 
            string contractName,
            int dialogLifetimeSeconds)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public void EndDialog(Guid dialogHandle)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public ServiceBrokerMessage ReceiveMessage(string queueName)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public void SendMessage(ServiceBrokerMessage serviceBrokerMessage)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        public void CleanupAllConversations()
        {
            throw new NotImplementedException();
        }
    }
}