using VLM.Personnel.SharedKernel.Common;
using VLM.Personnel.SharedKernel.DTOs;

namespace VLM.Personnel.Application.Interfaces.Services
{
    public interface IRequisitionService
    {
        Task<ApiResponse<IEnumerable<RequisitionListDto>>> GetAllAsync();
        Task<ApiResponse<RequisitionDto>> GetByIdAsync(long requisitionId);
        Task<ApiResponse<long>> CreateAsync(RequisitionCreateDto dto);
        Task<ApiResponse> UpdateAsync(RequisitionUpdateDto dto);
        Task<ApiResponse> DeleteAsync(long requisitionId);

        Task<ApiResponse<RequisitionDetailDto>> GetDetailByIdAsync(long detailId);
        Task<ApiResponse<long>> AddDetailAsync(long requisitionId, RequisitionDetailCreateDto dto);
        Task<ApiResponse> UpdateDetailAsync(long detailId, RequisitionDetailCreateDto dto);
        Task<ApiResponse> DeleteDetailAsync(long detailId);
    }
}