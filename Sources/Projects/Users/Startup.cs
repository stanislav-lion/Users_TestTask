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
    using Microsoft.Net.Http.Headers;
    using Users.CommonNames;
    using Microsoft.AspNetCore.Authentication.JwtBearer;
    using Microsoft.IdentityModel.Tokens;
    using System.Text;
    using System.Collections.Generic;
    using Users.Extensions;

    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        public IContainer ApplicationContainer { get; private set; }
        
        // ConfigureServices is where you register dependencies.
        // This method gets called by the runtime.
        // Use this method to add services to the container.
        public IServiceProvider ConfigureServices(IServiceCollection services)
        {
            // Add services to the collection.
            services
                .AddMvc()
                .SetCompatibilityVersion(CompatibilityVersion.Version_2_1)
                .AddXmlDataContractSerializerFormatters()
                .AddMvcOptions(options =>
                {
                    options.FormatterMappings.SetMediaTypeMappingForFormat(
                        Format.XmlFormat.Xml, 
                        new MediaTypeHeaderValue(Format.XmlFormat.ApplicationXml));
                });

            services
                .Configure<ConnectionString>(
                    Configuration.GetSection(nameof(ConnectionString)))
                .Configure<JwtSettings>(
                    Configuration.GetSection(nameof(JwtSettings)))
                .Configure<Users.AppSettings.AppSettings>(
                    Configuration.GetSection(nameof(Users.AppSettings.AppSettings)));

            var jwtSettings = Configuration.GetSection(nameof(JwtSettings))
                .Get<JwtSettings>();
            
            // Set authentication scheme for JWT and set JWT provider configuration.
            services.AddAuthentication(options =>
                {
                    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
                })
                .AddJwtBearer(options =>
                {
                    options.RequireHttpsMetadata = false;
                    options.SaveToken = true;
                    options.TokenValidationParameters = new TokenValidationParameters
                    {
                        ValidateIssuer = false,
                        ValidateIssuerSigningKey = true,
                        ValidateAudience = false,
                        ValidateLifetime = true,
                        IssuerSigningKey = new SymmetricSecurityKey(
                            Encoding.ASCII.GetBytes(jwtSettings.Key))
                    };
                });

            services.AddMemoryCache();
            
            // Register the Swagger generator, defining 1 or more Swagger documents.
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new Info
                {
                    Title = Parameters.Authorization,
                    Version = "v1"
                });
                c.AddSecurityDefinition(Parameters.Bearer, new ApiKeyScheme
                {
                    In = Parameters.Header.FirstCharToLower(),
                    Description = Resource.SwaggerSecurityDefinition,
                    Name = Parameters.Authorization,
                    Type = Parameters.ApiKey.FirstCharToLower()
                });

                c.AddSecurityRequirement(new Dictionary<string, IEnumerable<string>>
                {
                    { Parameters.Bearer, new string[] { } }
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
            services
                .AddMvc()
                .SetCompatibilityVersion(CompatibilityVersion.Version_2_1)
                .AddXmlDataContractSerializerFormatters()
                .AddMvcOptions(options =>
                {
                    options.FormatterMappings.SetMediaTypeMappingForFormat(
                        Format.XmlFormat.Xml, 
                        new MediaTypeHeaderValue(Format.XmlFormat.ApplicationXml));
                });

            services
                .Configure<ConnectionString>(
                    Configuration.GetSection(nameof(ConnectionString)))
                .Configure<ConnectionString>(
                    Configuration.GetSection(nameof(JwtSettings)))
                .Configure<JwtSettings>(
                    Configuration.GetSection(nameof(Users.AppSettings.AppSettings)));

            var jwtSettings = Configuration.GetSection(nameof(JwtSettings))
                .Get<JwtSettings>();
            
            // Set authentication scheme for JWT and set JWT provider configuration.
            services.AddAuthentication(options =>
                {
                    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
                })
                .AddJwtBearer(options =>
                {
                    options.RequireHttpsMetadata = false;
                    options.SaveToken = true;
                    options.TokenValidationParameters = new TokenValidationParameters
                    {
                        ValidateIssuer = false,
                        ValidateIssuerSigningKey = true,
                        ValidateAudience = false,
                        ValidateLifetime = true,
                        IssuerSigningKey = new SymmetricSecurityKey(
                            Encoding.ASCII.GetBytes(jwtSettings.Key))
                    };
                });

            services.AddMemoryCache();
            
            EmbeddedServicesConfigurator.AddScoped(services);
            // EmbeddedServicesConfigurator.AddSingleton(services);
            // EmbeddedServicesConfigurator.AddTransient(services);

            // Register the Swagger generator, defining 1 or more Swagger documents.
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new Info
                {
                    Title = Parameters.Authorization,
                    Version = "v1"
                });
                c.AddSecurityDefinition(Parameters.Bearer, new ApiKeyScheme
                {
                    In = Parameters.Header.FirstCharToLower(),
                    Description = CommonStrings.SwaggerSecurityDefinition,
                    Name = Parameters.Authorization,
                    Type = Parameters.ApiKey.FirstCharToLower()
                });

                c.AddSecurityRequirement(new Dictionary<string, IEnumerable<string>>
                {
                    { Parameters.Bearer, new string[] { } }
                });
            });
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

            applicationBuilder.UseAuthentication();

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