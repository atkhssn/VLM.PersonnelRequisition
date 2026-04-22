using Mapster;
using VLM.Personnel.Application.Interfaces.Repositories;
using VLM.Personnel.Application.Interfaces.Services;
using VLM.Personnel.Domain.Entities;
using VLM.Personnel.SharedKernel.Common;
using VLM.Personnel.SharedKernel.DTOs;

namespace VLM.Personnel.Application.Services
{
    public class RequisitionService : IRequisitionService
    {
        private readonly IRequisitionRepository _repo;

        public RequisitionService(IRequisitionRepository repo)
        {
            _repo = repo;
        }

        public async Task<ApiResponse<IEnumerable<RequisitionListDto>>> GetAllAsync()
        {
            var data = await _repo.GetAllAsync();
            return ApiResponse<IEnumerable<RequisitionListDto>>.Ok(data);
        }

        public async Task<ApiResponse<RequisitionDto>> GetByIdAsync(long requisitionId)
        {
            var data = await _repo.GetByIdAsync(requisitionId);
            if (data is null)
                return ApiResponse<RequisitionDto>.Fail($"Requisition {requisitionId} not found.");
            return ApiResponse<RequisitionDto>.Ok(data);
        }

        public async Task<ApiResponse<long>> CreateAsync(RequisitionCreateDto dto)
        {
            var entity = dto.Adapt<Requisition>();
            var details = dto.Details.Select(d => d.Adapt<RequisitionDetail>()).ToList();
            entity.Status = entity.Status.ToUpper();
            var newId = await _repo.CreateAsync(entity, details);
            return ApiResponse<long>.Ok(newId, "Requisition created successfully.");
        }

        public async Task<ApiResponse> UpdateAsync(RequisitionUpdateDto dto)
        {
            var entity = dto.Adapt<Requisition>();
            entity.RequisitionId = dto.RequisitionId;
            entity.Status = entity.Status.ToUpper();

            var details = dto.Details.Select(d =>
            {
                var detail = d.Adapt<RequisitionDetail>();
                detail.RequisitionId = dto.RequisitionId;
                detail.CreatedAt = DateTime.UtcNow;
                return detail;
            }).ToList();

            var deletedIds = dto.DeletedDetailIds ?? new List<long>();

            var success = await _repo.UpdateAsync(entity, details, deletedIds);

            return success
                ? ApiResponse.Ok("Requisition updated successfully.")
                : ApiResponse.Fail("Requisition not found or update failed.");
        }

        public async Task<ApiResponse> DeleteAsync(long requisitionId)
        {
            var success = await _repo.DeleteAsync(requisitionId);
            return success
                ? ApiResponse.Ok("Requisition deleted successfully.")
                : ApiResponse.Fail("Requisition not found.");
        }

        public async Task<ApiResponse<RequisitionDetailDto>> GetDetailByIdAsync(long detailId)
        {
            var data = await _repo.GetDetailByIdAsync(detailId);
            if (data is null)
                return ApiResponse<RequisitionDetailDto>.Fail($"Detail {detailId} not found.");
            return ApiResponse<RequisitionDetailDto>.Ok(data);
        }

        public async Task<ApiResponse<long>> AddDetailAsync(long requisitionId, RequisitionDetailCreateDto dto)
        {
            var detail = dto.Adapt<RequisitionDetail>();
            detail.RequisitionId = requisitionId;
            detail.CreatedAt = DateTime.UtcNow;
            var newId = await _repo.AddDetailAsync(detail);
            return ApiResponse<long>.Ok(newId, "Detail added successfully.");
        }

        public async Task<ApiResponse> UpdateDetailAsync(long detailId, RequisitionDetailCreateDto dto)
        {
            var detail = dto.Adapt<RequisitionDetail>();
            detail.RequisitionDetailId = detailId;
            var success = await _repo.UpdateDetailAsync(detail);
            return success
                ? ApiResponse.Ok("Detail updated successfully.")
                : ApiResponse.Fail("Detail not found.");
        }

        public async Task<ApiResponse> DeleteDetailAsync(long detailId)
        {
            var success = await _repo.DeleteDetailAsync(detailId);
            return success
                ? ApiResponse.Ok("Detail deleted successfully.")
                : ApiResponse.Fail("Detail not found.");
        }
    }
}