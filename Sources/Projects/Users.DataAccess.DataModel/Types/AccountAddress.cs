namespace Users.DataAccess.DataModel.Types
{
    using System.ComponentModel.DataAnnotations;
    using Users.DataAccess.DataModel.Enums;

    /// <summary>
    ///     Account address.
    /// </summary>
    public sealed class AccountAddress
    {
        /// <summary>
        ///     Gets or sets account identifier.
        /// </summary>
        public int AccountId { get; set; }

        /// <summary>
        ///     Gets or sets address type.
        /// </summary>
        public AddressType AddressType { get; set; }

        /// <summary>
        ///     Gets or sets address line 1.
        /// </summary>
        [Required(AllowEmptyStrings = true)]
        [StringLength(100)]
        public string AddressLine1 { get; set; }

        /// <summary>
        ///     Gets or sets address line 2.
        /// </summary>
        [Required(AllowEmptyStrings = true)]
        [StringLength(100)]
        public string AddressLine2 { get; set; }

        /// <summary>
        ///     Gets or sets address line 3.
        /// </summary>
        [Required(AllowEmptyStrings = true)]
        [StringLength(100)]
        public string AddressLine3 { get; set; }

        /// <summary>
        ///     Gets or sets city.
        /// </summary>
        [Required(AllowEmptyStrings = true)]
        [StringLength(100)]
        public string City { get; set; }

        /// <summary>
        ///     Gets or sets county.
        /// </summary>
        [Required(AllowEmptyStrings = true)]
        [StringLength(100)]
        public string County { get; set; }

        /// <summary>
        ///     Gets or sets state of province.
        /// </summary>
        [Required(AllowEmptyStrings = true)]
        [StringLength(50)]
        public string StateProvince { get; set; }

        /// <summary>
        ///     Gets or sets postal code.
        /// </summary>
        [Required(AllowEmptyStrings = true)]
        [StringLength(15)]
        public string PostalCode { get; set; }

        /// <summary>
        ///     Gets or sets country two letter code.
        /// </summary>
        [Required(AllowEmptyStrings = false)]
        [StringLength(2, MinimumLength = 2)]
        public string CountryTwoLetterCode { get; set; }
    }
}