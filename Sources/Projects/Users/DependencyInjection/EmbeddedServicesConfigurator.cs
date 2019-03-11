namespace Users.DependencyInjection
{
    using Microsoft.Extensions.DependencyInjection;
    using Users.Authentication.Interfaces;
    using Users.Settings;
    using Users.DataAccess.Database.Repositories;
    using Users.DataAccess.Repository;
    using Users.Services;

    public class EmbeddedServicesConfigurator
    {
        public static void AddScoped(
            IServiceCollection services,
            string connectionString)
        {
            services.AddScoped<IUserService, UserService>();

            services.AddScoped<IUserRepository>(
                userRepository => new UserRepository(
                    DBSetting.GetUserContext(connectionString))
            );

            services.AddScoped<IUserRoleRepository>(
                userRoleRepository => new UserRoleRepository(
                    DBSetting.GetUserContext(connectionString))
            );

            services.AddScoped<IAccountRepository>(
                userRepository => new AccountRepository(
                    DBSetting.GetUserContext(connectionString))
            );

            services.AddScoped<IAccountRoleRepository>(
                userRepository => new AccountRoleRepository(
                    DBSetting.GetUserContext(connectionString))
            );

            services.AddScoped<IAccountAddressRepository>(
                userRepository => new AccountAddressRepository(
                    DBSetting.GetUserContext(connectionString))
            );
        }

        public static void AddSingleton(
            IServiceCollection services,
            string connectionString)
        {
            services.AddSingleton<IUserService, UserService>();

            services.AddSingleton<IUserRepository>(
                userRepository => new UserRepository(
                    DBSetting.GetUserContext(connectionString))
            );

            services.AddSingleton<IUserRoleRepository>(
                userRoleRepository => new UserRoleRepository(
                    DBSetting.GetUserContext(connectionString))
            );

            services.AddSingleton<IAccountRepository>(
                userRepository => new AccountRepository(
                    DBSetting.GetUserContext(connectionString))
            );

            services.AddSingleton<IAccountRoleRepository>(
                userRepository => new AccountRoleRepository(
                    DBSetting.GetUserContext(connectionString))
            );

            services.AddSingleton<IAccountAddressRepository>(
                userRepository => new AccountAddressRepository(
                    DBSetting.GetUserContext(connectionString))
            );
        }

        public static void AddTransient(
            IServiceCollection services,
            string connectionString)
        {
            services.AddTransient<IUserService, UserService>();

            services.AddTransient<IUserRepository>(
                userRepository => new UserRepository(
                    DBSetting.GetUserContext(connectionString))
            );

            services.AddTransient<IUserRoleRepository>(
                userRoleRepository => new UserRoleRepository(
                    DBSetting.GetUserContext(connectionString))
            );

            services.AddTransient<IAccountRepository>(
                userRepository => new AccountRepository(
                    DBSetting.GetUserContext(connectionString))
            );

            services.AddTransient<IAccountRoleRepository>(
                userRepository => new AccountRoleRepository(
                    DBSetting.GetUserContext(connectionString))
            );

            services.AddTransient<IAccountAddressRepository>(
                userRepository => new AccountAddressRepository(
                    DBSetting.GetUserContext(connectionString))
            );
        }
    }
}