namespace Users.DependencyInjection
{
    using Autofac;
    using Autofac.Extensions.DependencyInjection;
    using Users.DataAccess.Repository;
    using Users.DataAccess.Database.Repositories;
    using Microsoft.Extensions.DependencyInjection;
    using Users.CommonNames;
    using Users.Extensions;
    using Users.CommonSettings;
    using Users.Authentication.Interfaces;
    using Users.Services;

    public class AutofacConfigurator
    {
        public static AutofacServiceProvider GetAutofacServiceProvider(
            IServiceCollection services,
            IContainer applicationContainer)
        {
            // Create the container builder.
            var builder = new ContainerBuilder();

            // When you do service population,
            // it will include your controller types automatically.
            builder.Populate(services);

            // Register dependencies, populate the services from
            // the collection, and build the container.

            // If you want to set up a controller for, say, property injection
            // you can override the controller registration after populating services.
            builder.RegisterType<UserService>()
                .As<IUserService>()
                .WithParameter(
                    Parameters.UserContext.FirstCharToLower(),
                    Settings.GetUserContext()
                );

            builder.RegisterType<UserRepository>()
                .As<IUserRepository>()
                .WithParameter(
                    Parameters.UserContext.FirstCharToLower(),
                    Settings.GetUserContext()
                );

            builder.RegisterType<UserRoleRepository>()
                .As<IUserRoleRepository>()
                .WithParameter(
                    Parameters.UserContext.FirstCharToLower(),
                    Settings.GetUserContext()
                );

            builder.RegisterType<AccountRepository>()
                .As<IAccountRepository>()
                .WithParameter(
                    Parameters.UserContext.FirstCharToLower(),
                    Settings.GetUserContext()
                );

            builder.RegisterType<AccountRoleRepository>()
                .As<IAccountRoleRepository>()
                .WithParameter(
                    Parameters.UserContext.FirstCharToLower(),
                    Settings.GetUserContext()
                );

            builder.RegisterType<AccountAddressRepository>()
                .As<IAccountAddressRepository>()
                .WithParameter(
                    Parameters.UserContext.FirstCharToLower(),
                    Settings.GetUserContext()
                );

            applicationContainer = builder.Build();

            // Create the IServiceProvider based on the container.
            return new AutofacServiceProvider(applicationContainer);
        }
    }
}