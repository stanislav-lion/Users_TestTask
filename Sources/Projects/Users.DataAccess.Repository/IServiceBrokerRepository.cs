namespace Users.DataAccess.Repository
{
    using System;
    using Users.DataAccess.DataModel.Types;

    /// <summary>
    ///     Service broker repository.
    /// </summary>
    public interface IServiceBrokerRepository
    {
        /// <summary>
        ///     Begins dialog.
        /// </summary>
        /// <param name="initiatorServiceName">Initiator service name.</param>
        /// <param name="targetServiceName">Target service name.</param>
        /// <param name="contractName">Contract name.</param>
        /// <param name="dialogLifetimeSeconds">Dialog lifetime in seconds.</param>
        /// <returns>Dialog unique identifier.</returns>
        Guid BeginDialog(
            string initiatorServiceName,
            string targetServiceName,
            string contractName,
            int dialogLifetimeSeconds);

        /// <summary>
        ///     Ends dialog.
        /// </summary>
        /// <param name="dialogHandle">Dialog unique identifier.</param>
        void EndDialog(Guid dialogHandle);

        /// <summary>
        ///     Receives message from queue.
        /// </summary>
        /// <param name="queueName">Queue name.</param>
        /// <returns>Message.</returns>
        ServiceBrokerMessage ReceiveMessage(string queueName);

        /// <summary>
        ///     Sends message.
        /// </summary>
        /// <param name="serviceBrokerMessage">Message.</param>
        void SendMessage(ServiceBrokerMessage serviceBrokerMessage);

        /// <summary>
        ///     Cleans all conversations.
        /// </summary>
        void CleanupAllConversations();
    }
}