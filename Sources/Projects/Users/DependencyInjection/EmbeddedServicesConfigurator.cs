namespace Users.DependencyInjection
{
    using Microsoft.Extensions.DependencyInjection;
    using Users.DataAccess.Database.Contexts;
    using Users.DataAccess.Database.Repositories;
    using Users.DataAccess.Repository;

    public class EmbeddedServicesConfigurator
    {
        public static void AddScoped(IServiceCollection serviceCollection)
        {
            serviceCollection.AddScoped<IUserRepository>(
                userRepository => new UserRepository(new UserContext())
            );

            serviceCollection.AddScoped<IUserRoleRepository>(
                userRoleRepository => new UserRoleRepository(new UserContext())
            );
        }

        public static void AddSingleton(IServiceCollection serviceCollection)
        {
            serviceCollection.AddSingleton<IUserRepository>(
                userRepository => new UserRepository(new UserContext())
            );

            serviceCollection.AddSingleton<IUserRoleRepository>(
                userRoleRepository => new UserRoleRepository(new UserContext())
            );
        }

        public static void AddTransient(IServiceCollection serviceCollection)
        {
            serviceCollection.AddTransient<IUserRepository>(
                userRepository => new UserRepository(new UserContext())
            );

            serviceCollection.AddTransient<IUserRoleRepository>(
                userRoleRepository => new UserRoleRepository(new UserContext())
            );
        }
    }
}