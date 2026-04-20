using VLM.Personnel.SharedKernel.Common;
using VLM.Personnel.SharedKernel.DTOs;

namespace VLM.Personnel.Application.Interfaces.Services
{
    public interface ILookupService
    {
        Task<ApiResponse<IEnumerable<DivisionDto>>> GetDivisionsAsync();
        Task<ApiResponse<IEnumerable<DepartmentDto>>> GetDepartmentsAsync();
        Task<ApiResponse<IEnumerable<DepartmentDto>>> GetDepartmentsByDivisionAsync(int divisionId);
        Task<ApiResponse<IEnumerable<DesignationDto>>> GetDesignationsAsync();
        Task<ApiResponse<IEnumerable<PerspectiveDto>>> GetPerspectivesAsync();
    }
}