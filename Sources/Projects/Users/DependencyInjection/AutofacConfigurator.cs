namespace Users.DependencyInjection
{
    using Autofac;
    using Autofac.Extensions.DependencyInjection;
    using Users.DataAccess.Repository;
    using Users.DataAccess.Database.Repositories;
    using Users.DataAccess.Database.Contexts;
    using Microsoft.Extensions.DependencyInjection;
    using Users.CommonNames;
    using Users.Extensions;

    public class AutofacConfigurator
    {
        public static AutofacServiceProvider GetAutofacServiceProvider(
            IServiceCollection serviceCollection,
            IContainer container)
        {
            // Create the container builder.
            var builder = new ContainerBuilder();

            // When you do service population,
            // it will include your controller types automatically.
            builder.Populate(serviceCollection);

            // Register dependencies, populate the services from
            // the collection, and build the container.

            // If you want to set up a controller for, say, property injection
            // you can override the controller registration after populating services.
            builder.RegisterType<UserRepository>()
                .As<IUserRepository>()
                .WithParameter(Parameters.DbContext.FirstCharToLower(), new UserContext());

            builder.RegisterType<UserRoleRepository>()
                .As<IUserRoleRepository>()
                .WithParameter(Parameters.DbContext.FirstCharToLower(), new UserContext());

            container = builder.Build();

            // Create the IServiceProvider based on the container.
            return new AutofacServiceProvider(container);
        }
    }
}