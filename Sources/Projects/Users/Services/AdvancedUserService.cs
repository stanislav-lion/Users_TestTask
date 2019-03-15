namespace Users.Services
{
    using Microsoft.Extensions.Caching.Memory;
    using Microsoft.Extensions.Options;
    using System;
    using System.Reflection;
    using Users.Authentication.AppSettings;
    using Users.Cache.AppSettings;
    using Users.CustomAttributes;
    using Users.DataAccess.Repository;

    public class AdvancedUserService : UserService
    {
        public AdvancedUserService(
            IUserRepository userRepository,
            IAccountRoleRepository accountRoleRepository,
            IOptions<JwtSetting> jwtSetting,
            IOptions<CacheSetting> cacheSetting,
            IMemoryCache memoryCache)
            : base(
                userRepository,
                accountRoleRepository,
                jwtSetting,
                cacheSetting,
                memoryCache)
        {

        }

        public override string CurrentUserRole => GetCurrentUserRole();

        private new string GetCurrentUserRole()
        {
            string сurrentUserRole = base.CurrentUserRole;

            Type type = this.GetType();

            foreach (PropertyInfo propertyInfo in type.GetProperties())
            {
                if (propertyInfo.Name == nameof(CurrentUserRole))
                {
                    foreach (Attribute attribute in propertyInfo.GetCustomAttributes())
                    {
                        if (attribute is ReplaceCharsAttribute)
                        {
                            var replaceCharsAttribute = attribute as ReplaceCharsAttribute;

                            if (replaceCharsAttribute != null)
                            {
                                сurrentUserRole = сurrentUserRole.Replace(
                                    replaceCharsAttribute.OldValue,
                                    replaceCharsAttribute.NewValue);
                            }
                        }

                        if (attribute is ReplaceStringsAttribute)
                        {
                            var replaceStringsAttribute = attribute as ReplaceStringsAttribute;

                            if (replaceStringsAttribute != null)
                            {
                                сurrentUserRole = сurrentUserRole.Replace(
                                    replaceStringsAttribute.OldValue,
                                    replaceStringsAttribute.NewValue);
                            }
                        }
                    }
                }
            }

            return сurrentUserRole;
        }
    }
}