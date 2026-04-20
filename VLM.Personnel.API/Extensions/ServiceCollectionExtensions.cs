using Mapster;
using MapsterMapper;
using VLM.Personnel.Application.Interfaces.Repositories;
using VLM.Personnel.Application.Interfaces.Services;
using VLM.Personnel.Application.Mappings;
using VLM.Personnel.Application.Services;
using VLM.Personnel.Infrastructure.Data;
using VLM.Personnel.Infrastructure.Repositories;

namespace VLM.Personnel.API.Extensions
{
    public static class ServiceCollectionExtensions
    {
        public static IServiceCollection AddApplicationServices(this IServiceCollection services)
        {
            // Infrastructure
            services.AddSingleton<DbConnectionFactory>();
            services.AddScoped<DapperContext>();

            // Services
            services.AddScoped<ILookupService, LookupService>();
            services.AddScoped<IRequisitionService, RequisitionService>();

            // Repositories
            services.AddScoped<ILookupRepository, LookupRepository>();
            services.AddScoped<IRequisitionRepository, RequisitionRepository>();

            return services;
        }

        public static IServiceCollection AddMapster(this IServiceCollection services)
        {
            // Register Mapster config
            MapsterConfig.RegisterMappings();

            var config = TypeAdapterConfig.GlobalSettings;
            config.Scan(
                typeof(VLM.Personnel.Application.Mappings.MapsterConfig).Assembly
            );

            services.AddSingleton(config);
            services.AddScoped<IMapper, ServiceMapper>();

            return services;
        }
    }
}