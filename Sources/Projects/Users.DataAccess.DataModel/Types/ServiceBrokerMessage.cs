namespace Users.DataAccess.DataModel.Types
{
    using System;
    using System.ComponentModel.DataAnnotations;

    /// <summary>
    ///     Service Broker message.
    /// </summary>
    public sealed class ServiceBrokerMessage
    {
        /// <summary>
        ///     Gets or sets dialog unique identifier.
        /// </summary>
        public Guid DialogHandle { get; set; }

        /// <summary>
        ///     Gets or sets message type.
        /// </summary>
        [Required(AllowEmptyStrings = false)]
        public string MessageType { get; set; }

        /// <summary>
        ///     Gets or sets message data.
        /// </summary>
        [MinLength(1)]
        public byte[] MessageBody { get; set; }
    }
}