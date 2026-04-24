using Mapster;
using VLM.Personnel.Domain.Entities;
using VLM.Personnel.SharedKernel.DTOs;

namespace VLM.Personnel.Application.Mappings
{
    public static class MapsterConfig
    {
        public static void RegisterMappings()
        {
            TypeAdapterConfig<RequisitionCreateDto, Requisition>
                .NewConfig()
                .Map(dest => dest.Status, src => "DRAFT")
                .Map(dest => dest.CreatedAt, src => DateTime.Now)
                .Ignore(dest => dest.RequisitionId)
                .Ignore(dest => dest.RequisitionNo);

            TypeAdapterConfig<RequisitionUpdateDto, Requisition>
                .NewConfig()
                .Map(dest => dest.CreatedAt, src => DateTime.Now)
                .Ignore(dest => dest.RequisitionNo);

            TypeAdapterConfig<RequisitionDetailCreateDto, RequisitionDetail>
                .NewConfig()
                .Map(dest => dest.CreatedAt, src => DateTime.Now)
                .Ignore(dest => dest.RequisitionDetailId)
                .Ignore(dest => dest.RequisitionId);

            TypeAdapterConfig<RequisitionDetailUpdateDto, RequisitionDetail>
                .NewConfig()
                .Map(dest => dest.CreatedAt, src => DateTime.Now)
                .Ignore(dest => dest.RequisitionId);
        }
    }
}