namespace Users.DataAccess.DataModel.Types
{
    using System;
    using System.ComponentModel.DataAnnotations;

    /// <summary>
    ///     Account.
    /// </summary>
    public sealed class Account
    {
        /// <summary>
        ///     Gets or sets account identifier.
        /// </summary>
        public int AccountId { get; set; }

        /// <summary>
        ///     Gets or sets account unique identifier.
        /// </summary>
        public Guid? AccountGuid { get; set; }

        /// <summary>
        ///     Gets or sets account number.
        /// </summary>
        [Required(AllowEmptyStrings = false)]
        [StringLength(8)]
        public string AccountNumber { get; set; }

        /// <summary>
        ///     Gets or sets account name.
        /// </summary>
        [Required(AllowEmptyStrings = false)]
        [StringLength(50)]
        public string AccountName { get; set; }

        /// <summary>
        ///     Gets or sets a value indicating whether account is enabled.
        /// </summary>
        public bool IsEnabled { get; set; }

        /// <summary>
        ///     Gets or sets account time zone.
        /// </summary>
        public int? TimeZone { get; set; }

        /// <summary>
        ///     Gets or sets password expiration period in days.
        /// </summary>
        public int PasswordExpirationPeriodInDays { get; set; }

        /// <summary>
        ///     Gets or sets data storage time in hours.
        /// </summary>
        public int DataStorageTimeHrs { get; set; }

        /// <summary>
        ///     Gets or sets number of allowed Code Management applications.
        /// </summary>
        public int NumberOfCodeManagementApps { get; set; }
    }
}