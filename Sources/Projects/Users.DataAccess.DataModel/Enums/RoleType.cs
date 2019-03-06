namespace Users.DataAccess.DataModel.Enums
{
    using System.ComponentModel;

    /// <summary>
    ///     Role type.
    /// </summary>
    public enum RoleType
    {
        /// <summary>
        ///     Application administrator.
        /// </summary>
        [Description("APPLICATION_ADMINISTRATOR")]
        ApplicationAdministrator = 0x0001,

        /// <summary>
        ///     Company administrator.
        /// </summary>
        [Description("COMPANY_ADMINISTRATOR")]
        CompanyAdministrator = 0x0002,

        /// <summary>
        ///     Company user.
        /// </summary>
        [Description("COMPANY_USER")]
        CompanyUser = 0x0004,

        /// <summary>
        ///     System administrator.
        /// </summary>
        [Description("SYSTEM_ADMINISTRATOR")]
        SystemAdministrator = 0x0010,

        /// <summary>
        ///     Account administrator.
        /// </summary>
        [Description("ACCOUNT_ADMINISTRATOR")]
        AccountAdministrator = 0x0020,
        
        /// <summary>
        ///     Account support.
        /// </summary>
        [Description("ACCOUNT_SUPPORT")]
        AccountSupport = 0x0040,

        /// <summary>
        ///     Network manager.
        /// </summary>
        [Description("NETWORK_MANAGER")]
        NetworkManager = 0x0080,

        /// <summary>
        ///     Site coordinator.
        /// </summary>
        [Description("SITE_COORDINATOR")]
        SiteCoordinator = 0x00000100,

        /// <summary>
        ///     Service specialist.
        /// </summary>
        [Description("SERVICE_SPECIALIST")]
        ServiceSpecialist = 0x00000200,

        /// <summary>
        ///     Guest.
        /// </summary>
        [Description("GUEST")]
        Guest = 0x00002000
    }
}