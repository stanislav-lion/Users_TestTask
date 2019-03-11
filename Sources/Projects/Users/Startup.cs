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
    using Users.DataAccess.Database.AppSettings;
    using Users.Authentication.AppSettings;
    using Users.Cache.AppSettings;

    public class Startup
    {
        private JwtSetting _jwtSetting;
        private ConnectionString _connectionString;
        private SQLServerConnectionString _sqlServerConnectionString;
        private PostgreSQLConnectionString _postgreSQLConnectionString;
        private CacheSetting _cacheSetting;
        private AppSetting _appSetting;

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

            _jwtSetting = Configuration.GetSection(nameof(JwtSetting))
                .Get<JwtSetting>();
            _connectionString = Configuration.GetSection(nameof(ConnectionString))
                .Get<ConnectionString>();
            _sqlServerConnectionString = Configuration.GetSection(nameof(SQLServerConnectionString))
                .Get<SQLServerConnectionString>();
            _postgreSQLConnectionString = Configuration.GetSection(nameof(PostgreSQLConnectionString))
                .Get<PostgreSQLConnectionString>();
            _cacheSetting = Configuration.GetSection(nameof(CacheSetting))
                .Get<CacheSetting>();
            _appSetting = Configuration.GetSection(nameof(AppSetting))
                .Get<AppSetting>();

            services
                .Configure<JwtSetting>(
                    Configuration.GetSection(nameof(JwtSetting)))
                .Configure<ConnectionString>(
                    Configuration.GetSection(nameof(ConnectionString)))
                .Configure<SQLServerConnectionString>(
                    Configuration.GetSection(nameof(SQLServerConnectionString)))
                .Configure<PostgreSQLConnectionString>(
                    Configuration.GetSection(nameof(PostgreSQLConnectionString)))
                .Configure<CacheSetting>(
                    Configuration.GetSection(nameof(CacheSetting)))
                .Configure<AppSetting>(
                    Configuration.GetSection(nameof(AppSetting)));
            
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
                            Encoding.ASCII.GetBytes(_jwtSetting.Key))
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
                ApplicationContainer,
                _sqlServerConnectionString.UsersConnectionString
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

            _jwtSetting = Configuration.GetSection(nameof(JwtSetting))
                .Get<JwtSetting>();
            _connectionString = Configuration.GetSection(nameof(ConnectionString))
                .Get<ConnectionString>();
            _sqlServerConnectionString = Configuration.GetSection(nameof(SQLServerConnectionString))
                .Get<SQLServerConnectionString>();
            _postgreSQLConnectionString = Configuration.GetSection(nameof(PostgreSQLConnectionString))
                .Get<PostgreSQLConnectionString>();
            _cacheSetting = Configuration.GetSection(nameof(CacheSetting))
                .Get<CacheSetting>();
            _appSetting = Configuration.GetSection(nameof(AppSetting))
                .Get<AppSetting>();

            services
                .Configure<JwtSetting>(
                    Configuration.GetSection(nameof(JwtSetting)))
                .Configure<ConnectionString>(
                    Configuration.GetSection(nameof(ConnectionString)))
                .Configure<SQLServerConnectionString>(
                    Configuration.GetSection(nameof(SQLServerConnectionString)))
                .Configure<PostgreSQLConnectionString>(
                    Configuration.GetSection(nameof(PostgreSQLConnectionString)))
                .Configure<CacheSetting>(
                    Configuration.GetSection(nameof(CacheSetting)))
                .Configure<AppSetting>(
                    Configuration.GetSection(nameof(AppSetting)));
            
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
                            Encoding.ASCII.GetBytes(_jwtSetting.Key))
                    };
                });

            services.AddMemoryCache();
            
            EmbeddedServicesConfigurator.AddScoped(
                services,
                _sqlServerConnectionString.UsersConnectionString);
            
            //EmbeddedServicesConfigurator.AddSingleton(
            //    services,
            //    _sqlServerConnectionString.UsersConnectionString);
            
            //EmbeddedServicesConfigurator.AddTransient(
            //    services,
            //    _sqlServerConnectionString.UsersConnectionString);

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
                    _appSetting.SwaggerEndpoint,
                    Resource.SwaggerEndpointName
                );
            });
        }
    }
}