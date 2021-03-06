﻿namespace Users.DependencyInjection
{
    using Autofac;
    using Autofac.Extensions.DependencyInjection;
    using Users.DataAccess.Repository;
    using Users.DataAccess.Database.Repositories;
    using Microsoft.Extensions.DependencyInjection;
    using Users.CommonNames;
    using Users.Extensions;
    using Users.Settings;
    using Users.Authentication.Interfaces;
    using Users.Services;
    using Users.DataAccess.Database;

    public class AutofacConfigurator
    {
        public static AutofacServiceProvider GetAutofacServiceProvider(
            IServiceCollection services,
            IContainer applicationContainer,
            DBMS dbms,
            string connectionString)
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
            builder.RegisterType<AdvancedUserService>()
                .As<IUserService>()
                .WithParameter(
                    Parameters.UserContext.FirstCharToLower(),
                    DBSetting.GetUserContext(dbms, connectionString)
                );

            builder.RegisterType<UserRepository>()
                .As<IUserRepository>()
                .WithParameter(
                    Parameters.UserContext.FirstCharToLower(),
                    DBSetting.GetUserContext(dbms, connectionString)
                );

            builder.RegisterType<UserRoleRepository>()
                .As<IUserRoleRepository>()
                .WithParameter(
                    Parameters.UserContext.FirstCharToLower(),
                    DBSetting.GetUserContext(dbms, connectionString)
                );

            builder.RegisterType<AccountRepository>()
                .As<IAccountRepository>()
                .WithParameter(
                    Parameters.UserContext.FirstCharToLower(),
                    DBSetting.GetUserContext(dbms, connectionString)
                );

            builder.RegisterType<AccountRoleRepository>()
                .As<IAccountRoleRepository>()
                .WithParameter(
                    Parameters.UserContext.FirstCharToLower(),
                    DBSetting.GetUserContext(dbms, connectionString)
                );

            builder.RegisterType<AccountAddressRepository>()
                .As<IAccountAddressRepository>()
                .WithParameter(
                    Parameters.UserContext.FirstCharToLower(),
                    DBSetting.GetUserContext(dbms, connectionString)
                );

            applicationContainer = builder.Build();

            // Create the IServiceProvider based on the container.
            return new AutofacServiceProvider(applicationContainer);
        }
    }
}