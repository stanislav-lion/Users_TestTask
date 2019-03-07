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
        }

        public static void AddSingleton(IServiceCollection serviceCollection)
        {
            serviceCollection.AddSingleton<IUserRepository>(
                userRepository => new UserRepository(Settings.GetUserContext())
            );

            serviceCollection.AddSingleton<IUserRoleRepository>(
                userRoleRepository => new UserRoleRepository(Settings.GetUserContext())
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
        }
    }
}