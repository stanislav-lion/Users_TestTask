namespace Users.DataAccess.DataModel.Types
{
    using System;
    using System.ComponentModel.DataAnnotations;
    using Users.DataAccess.DataModel.Enums;

    /// <summary>
    ///     Account role.
    /// </summary>
    public sealed class AccountRole
    {
        /// <summary>
        ///     Gets or sets account role identifier.
        /// </summary>
        public int AccountRoleId { get; set; }

        /// <summary>
        ///     Gets or sets account role unique identifier.
        /// </summary>
        public Guid? AccountRoleGuid { get; set; }

        /// <summary>
        ///     Gets or sets account identifier.
        /// </summary>
        public int AccountId { get; set; }

        /// <summary>
        ///     Gets or sets account role name.
        /// </summary>
        [Required(AllowEmptyStrings = false)]
        [StringLength(40)]
        public string RoleName { get; set; }

        /// <summary>
        ///     Gets or sets account role type.
        /// </summary>
        public RoleType? RoleType { get; set; }

        /// <summary>
        ///     Gets or sets privilege type.
        /// </summary>
        public PrivilegeType? PrivilegeType { get; set; }
    }
}