namespace Users.DataAccess.DataModel.Types
{
    using System;
    using System.ComponentModel.DataAnnotations;
    using Users.DataAccess.DataModel.Attributes;

    /// <summary>
    ///     User.
    /// </summary>
    public sealed class User
    {
        /// <summary>
        ///     Gets or sets user identifier.
        /// </summary>
        public int UserId { get; set; }

        /// <summary>
        ///     Gets or sets user unique identifier.
        /// </summary>
        public Guid? UserGuid { get; set; }

        /// <summary>
        ///     Gets or sets logon name.
        /// </summary>
        [Required(AllowEmptyStrings = false)]
        [StringLength(100)]
        public string LogonName { get; set; }

        /// <summary>
        ///     Gets or sets account identifier.
        /// </summary>
        public int? AccountId { get; set; }

        /// <summary>
        ///     Gets or sets first name.
        /// </summary>
        [Required(AllowEmptyStrings = false)]
        [StringLength(50)]
        public string FirstName { get; set; }

        /// <summary>
        ///     Gets or sets last name.
        /// </summary>
        [Required(AllowEmptyStrings = false)]
        [StringLength(100)]
        public string LastName { get; set; }

        /// <summary>
        ///     Gets or sets middle name.
        /// </summary>
        [Required(AllowEmptyStrings = true)]
        [StringLength(30)]
        public string MiddleName { get; set; }

        /// <summary>
        ///     Gets or sets password salt.
        /// </summary>
        [Required(AllowEmptyStrings = false)]
        [StringLength(40)]
        public string PasswordSalt { get; set; }

        /// <summary>
        ///     Gets or sets password hash.
        /// </summary>
        [Required(AllowEmptyStrings = false)]
        [StringLength(40)]
        public string PasswordHash { get; set; }

        /// <summary>
        ///     Gets or sets password change UTC.
        /// </summary>
        [DateTimeUtcKind]
        public DateTime? PasswordChangeUtc { get; set; }

        /// <summary>
        ///     Gets or sets a value indicating whether password must be changed flag.
        /// </summary>
        public bool PasswordMustBeChanged { get; set; }

        /// <summary>
        ///     Gets or sets a value indicating whether is logon enabled flag.
        /// </summary>
        public bool IsLogonEnabled { get; set; }

        /// <summary>
        ///     Gets or sets time zone.
        /// </summary>
        public int? TimeZone { get; set; }

        /// <summary>
        ///     Gets or sets culture code.
        /// </summary>
        [Required(AllowEmptyStrings = true)]
        [StringLength(10)]
        public string CultureCode { get; set; }
    }
}