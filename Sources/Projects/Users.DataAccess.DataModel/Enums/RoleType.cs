namespace Users.DataAccess.DataModel.Enums
{
    /// <summary>
    ///     Role type.
    /// </summary>
    public enum RoleType
    {
        /// <summary>
        ///     Application administrator.
        /// </summary>
        APPLICATION_ADMINISTRATOR = 0x0001,

        /// <summary>
        ///     Company administrator.
        /// </summary>
        COMPANY_ADMINISTRATOR = 0x0002,

        /// <summary>
        ///     Company user.
        /// </summary>
        COMPANY_USER = 0x0004
    }
}