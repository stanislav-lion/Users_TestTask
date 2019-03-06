namespace Users.DataAccess.DataModel.Types
{
    /// <summary>
    ///     User role.
    /// </summary>
    public sealed class UserRole
    {
        /// <summary>
        ///     Gets or sets user identifier.
        /// </summary>
        public int UserId { get; set; }

        /// <summary>
        ///     Gets or sets account role identifier.
        /// </summary>
        public int AccountRoleId { get; set; }
    }
}