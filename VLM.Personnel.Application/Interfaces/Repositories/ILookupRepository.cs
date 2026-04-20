using VLM.Personnel.SharedKernel.DTOs;

namespace VLM.Personnel.Application.Interfaces.Repositories
{
    public interface ILookupRepository
    {
        Task<IEnumerable<DivisionDto>> GetDivisionsAsync();
        Task<IEnumerable<DepartmentDto>> GetDepartmentsAsync();
        Task<IEnumerable<DepartmentDto>> GetDepartmentsByDivisionAsync(int divisionId);
        Task<IEnumerable<DesignationDto>> GetDesignationsAsync();
        Task<IEnumerable<PerspectiveDto>> GetPerspectivesAsync();
    }
}