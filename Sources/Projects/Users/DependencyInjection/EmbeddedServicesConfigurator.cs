namespace Users.DependencyInjection
{
    using Microsoft.Extensions.DependencyInjection;
    using Users.Authentication.Interfaces;
    using Users.Settings;
    using Users.DataAccess.Database.Repositories;
    using Users.DataAccess.Repository;
    using Users.Services;
    using Users.DataAccess.Database;

    public class EmbeddedServicesConfigurator
    {
        public static void AddScoped(
            IServiceCollection services,
            DBMS dbms,
            string connectionString)
        {
            services.AddScoped<IUserService, AdvancedUserService>();

            services.AddScoped<IUserRepository>(
                userRepository => new UserRepository(
                    DBSetting.GetUserContext(dbms, connectionString))
            );

            services.AddScoped<IUserRoleRepository>(
                userRoleRepository => new UserRoleRepository(
                    DBSetting.GetUserContext(dbms, connectionString))
            );

            services.AddScoped<IAccountRepository>(
                userRepository => new AccountRepository(
                    DBSetting.GetUserContext(dbms, connectionString))
            );

            services.AddScoped<IAccountRoleRepository>(
                userRepository => new AccountRoleRepository(
                    DBSetting.GetUserContext(dbms, connectionString))
            );

            services.AddScoped<IAccountAddressRepository>(
                userRepository => new AccountAddressRepository(
                    DBSetting.GetUserContext(dbms, connectionString))
            );
        }

        public static void AddSingleton(
            IServiceCollection services,
            DBMS dbms,
            string connectionString)
        {
            services.AddSingleton<IUserService, AdvancedUserService>();

            services.AddSingleton<IUserRepository>(
                userRepository => new UserRepository(
                    DBSetting.GetUserContext(dbms, connectionString))
            );

            services.AddSingleton<IUserRoleRepository>(
                userRoleRepository => new UserRoleRepository(
                    DBSetting.GetUserContext(dbms, connectionString))
            );

            services.AddSingleton<IAccountRepository>(
                userRepository => new AccountRepository(
                    DBSetting.GetUserContext(dbms, connectionString))
            );

            services.AddSingleton<IAccountRoleRepository>(
                userRepository => new AccountRoleRepository(
                    DBSetting.GetUserContext(dbms, connectionString))
            );

            services.AddSingleton<IAccountAddressRepository>(
                userRepository => new AccountAddressRepository(
                    DBSetting.GetUserContext(dbms, connectionString))
            );
        }

        public static void AddTransient(
            IServiceCollection services,
            DBMS dbms,
            string connectionString)
        {
            services.AddTransient<IUserService, AdvancedUserService>();

            services.AddTransient<IUserRepository>(
                userRepository => new UserRepository(
                    DBSetting.GetUserContext(dbms, connectionString))
            );

            services.AddTransient<IUserRoleRepository>(
                userRoleRepository => new UserRoleRepository(
                    DBSetting.GetUserContext(dbms, connectionString))
            );

            services.AddTransient<IAccountRepository>(
                userRepository => new AccountRepository(
                    DBSetting.GetUserContext(dbms, connectionString))
            );

            services.AddTransient<IAccountRoleRepository>(
                userRepository => new AccountRoleRepository(
                    DBSetting.GetUserContext(dbms, connectionString))
            );

            services.AddTransient<IAccountAddressRepository>(
                userRepository => new AccountAddressRepository(
                    DBSetting.GetUserContext(dbms, connectionString))
            );
        }
    }
}