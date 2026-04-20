using VLM.Personnel.Application.Interfaces.Repositories;
using VLM.Personnel.Application.Interfaces.Services;
using VLM.Personnel.SharedKernel.Common;
using VLM.Personnel.SharedKernel.DTOs;

namespace VLM.Personnel.Application.Services
{
    public class LookupService : ILookupService
    {
        private readonly ILookupRepository _repo;

        public LookupService(ILookupRepository repo)
        {
            _repo = repo;
        }

        public async Task<ApiResponse<IEnumerable<DivisionDto>>> GetDivisionsAsync()
        {
            var data = await _repo.GetDivisionsAsync();
            return ApiResponse<IEnumerable<DivisionDto>>.Ok(data);
        }

        public async Task<ApiResponse<IEnumerable<DepartmentDto>>> GetDepartmentsAsync()
        {
            var data = await _repo.GetDepartmentsAsync();
            return ApiResponse<IEnumerable<DepartmentDto>>.Ok(data);
        }

        public async Task<ApiResponse<IEnumerable<DepartmentDto>>> GetDepartmentsByDivisionAsync(int divisionId)
        {
            var data = await _repo.GetDepartmentsByDivisionAsync(divisionId);
            return ApiResponse<IEnumerable<DepartmentDto>>.Ok(data);
        }

        public async Task<ApiResponse<IEnumerable<DesignationDto>>> GetDesignationsAsync()
        {
            var data = await _repo.GetDesignationsAsync();
            return ApiResponse<IEnumerable<DesignationDto>>.Ok(data);
        }

        public async Task<ApiResponse<IEnumerable<PerspectiveDto>>> GetPerspectivesAsync()
        {
            var data = await _repo.GetPerspectivesAsync();
            return ApiResponse<IEnumerable<PerspectiveDto>>.Ok(data);
        }
    }
}