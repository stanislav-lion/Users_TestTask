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
    using Swashbuckle.AspNetCore.Swagger;
    using Users.AppSettings;

    public class Startup
    {
        public IConfiguration Configuration { get; }

        public IContainer ApplicationContainer { get; private set; }

        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        // ConfigureServices is where you register dependencies.
        // This method gets called by the runtime.
        // Use this method to add services to the container.
        public IServiceProvider ConfigureServices(IServiceCollection services)
        {
            // Add services to the collection.
            services.AddMvc()
                .SetCompatibilityVersion(CompatibilityVersion.Version_2_1);

            services.AddMemoryCache();

            services.Configure<ConnectionString>(Configuration.GetSection(nameof(ConnectionString)));
            services.Configure<Users.AppSettings.AppSettings>(
                Configuration.GetSection(nameof(Users.AppSettings.AppSettings)));

            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new Info
                {
                    Title = "Users Service API",
                    Version = "v1"
                });
            });

            // Create the IServiceProvider based on the container.
            return AutofacConfigurator.GetAutofacServiceProvider(
                services,
                ApplicationContainer
            );
        }

        // ConfigureServices is where you register dependencies.
        // This method gets called by the runtime.
        // Use this method to add services to the container.
        /*public void ConfigureServices(IServiceCollection services)
        {
            // Add services to the collection.
            services.AddMvc()
                .SetCompatibilityVersion(CompatibilityVersion.Version_2_1);
            
            services.AddMemoryCache();

            services.Configure<ConnectionString>(Configuration.GetSection(nameof(ConnectionString)));
            services.Configure<Users.AppSettings.AppSettings>(
                Configuration.GetSection(nameof(Users.AppSettings.AppSettings)));

            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new Info
                {
                    Title = "Users Service API",
                    Version = "v1"
                });
            });

            EmbeddedServicesConfigurator.AddScoped(services);

            // EmbeddedServicesConfigurator.AddSingleton(services);

            // EmbeddedServicesConfigurator.AddTransient(services);
        }*/

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

            applicationBuilder.UseSwagger();
            applicationBuilder.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint(
                    "/swagger/v1/swagger.json", 
                    "Users Service API"
                );
            });
        }
    }
}