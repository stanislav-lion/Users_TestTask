namespace Users.DependencyInjection
{
    using Microsoft.Extensions.DependencyInjection;
    using Users.CommonSettings;
    using Users.DataAccess.Database.Contexts;
    using Users.DataAccess.Database.Repositories;
    using Users.DataAccess.Repository;

    public class EmbeddedServicesConfigurator
    {
        public static void AddScoped(IServiceCollection serviceCollection)
        {
            serviceCollection.AddScoped<IUserRepository>(
                userRepository => new UserRepository(Settings.GetUserContext())
            );

            serviceCollection.AddScoped<IUserRoleRepository>(
                userRoleRepository => new UserRoleRepository(Settings.GetUserContext())
            );

            serviceCollection.AddScoped<IAccountRepository>(
                userRepository => new AccountRepository(Settings.GetUserContext())
            );

            serviceCollection.AddScoped<IAccountRoleRepository>(
                userRepository => new AccountRoleRepository(Settings.GetUserContext())
            );

            serviceCollection.AddScoped<IAccountAddressRepository>(
                userRepository => new AccountAddressRepository(Settings.GetUserContext())
            );
        }

        public static void AddSingleton(IServiceCollection serviceCollection)
        {
            serviceCollection.AddSingleton<IUserRepository>(
                userRepository => new UserRepository(Settings.GetUserContext())
            );

            serviceCollection.AddSingleton<IUserRoleRepository>(
                userRoleRepository => new UserRoleRepository(Settings.GetUserContext())
            );

            serviceCollection.AddSingleton<IAccountRepository>(
                userRepository => new AccountRepository(Settings.GetUserContext())
            );

            serviceCollection.AddSingleton<IAccountRoleRepository>(
                userRepository => new AccountRoleRepository(Settings.GetUserContext())
            );

            serviceCollection.AddSingleton<IAccountAddressRepository>(
                userRepository => new AccountAddressRepository(Settings.GetUserContext())
            );
        }

        public static void AddTransient(IServiceCollection serviceCollection)
        {
            serviceCollection.AddTransient<IUserRepository>(
                userRepository => new UserRepository(Settings.GetUserContext())
            );

            serviceCollection.AddTransient<IUserRoleRepository>(
                userRoleRepository => new UserRoleRepository(Settings.GetUserContext())
            );

            serviceCollection.AddTransient<IAccountRepository>(
                userRepository => new AccountRepository(Settings.GetUserContext())
            );

            serviceCollection.AddTransient<IAccountRoleRepository>(
                userRepository => new AccountRoleRepository(Settings.GetUserContext())
            );

            serviceCollection.AddTransient<IAccountAddressRepository>(
                userRepository => new AccountAddressRepository(Settings.GetUserContext())
            );
        }
    }
}