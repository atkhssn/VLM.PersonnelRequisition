using VLM.Personnel.Domain.Entities;
using VLM.Personnel.SharedKernel.DTOs;

namespace VLM.Personnel.Application.Interfaces.Repositories
{
    public interface IRequisitionRepository
    {
        // Requisition
        Task<IEnumerable<RequisitionListDto>> GetAllAsync();
        Task<RequisitionDto?> GetByIdAsync(long requisitionId);
        Task<long> CreateAsync(Requisition requisition, IEnumerable<RequisitionDetail> details);
        Task<bool> UpdateAsync(Requisition requisition, IEnumerable<RequisitionDetail> details, IEnumerable<long> deletedDetailIds);
        Task<bool> DeleteAsync(long requisitionId);

        // RequisitionDetail
        Task<RequisitionDetailDto?> GetDetailByIdAsync(long requisitionDetailId);
        Task<long> AddDetailAsync(RequisitionDetail detail);
        Task<bool> UpdateDetailAsync(RequisitionDetail detail);
        Task<bool> DeleteDetailAsync(long requisitionDetailId);
    }
}