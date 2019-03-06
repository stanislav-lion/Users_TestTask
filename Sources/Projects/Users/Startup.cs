namespace Users
{
    using System;
    using Autofac;
    using Microsoft.AspNetCore.Builder;
    using Microsoft.AspNetCore.Hosting;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.Extensions.Configuration;
    using Microsoft.Extensions.DependencyInjection;
    using Users.DependencyInjection;

    public class Startup
    {
        public IConfiguration Configuration { get; }

        public IContainer ApplicationContainer { get; private set; }

        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        // ConfigureServices is where you register dependencies.
        // This gets called by the runtime before the Configure method.
        // Use this method to add services to the container.
        public IServiceProvider ConfigureServices(IServiceCollection serviceCollection)
        {
            // Add services to the collection.
            serviceCollection.AddMvc()
                .SetCompatibilityVersion(CompatibilityVersion.Version_2_1);

            //services.AddTransient

            //services.AddScoped

            //services.AddSingleton

            // Create the IServiceProvider based on the container.
            return AutofacConfigurator.GetAutofacServiceProvider(
                serviceCollection,
                ApplicationContainer
            );
        }

        // This method gets called by the runtime.
        // Use this method to configure the HTTP request pipeline.
        public void Configure(
            IApplicationBuilder applicationBuilder, 
            IHostingEnvironment hostingEnvironment)
        {
            if (hostingEnvironment.IsDevelopment())
            {
                applicationBuilder.UseDeveloperExceptionPage();
            }
            else
            {
                applicationBuilder.UseHsts();
            }

            applicationBuilder.UseHttpsRedirection();
            applicationBuilder.UseMvc();
        }
    }
}