using Dapper;
using VLM.Personnel.Application.Interfaces.Repositories;
using VLM.Personnel.Infrastructure.Data;
using VLM.Personnel.SharedKernel.DTOs;

namespace VLM.Personnel.Infrastructure.Repositories
{
    public class LookupRepository : ILookupRepository
    {
        private readonly DapperContext _context;

        public LookupRepository(DapperContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<DivisionDto>> GetDivisionsAsync()
        {
            const string sql = @"
            SELECT DivisionId, DivisionName
            FROM core.Division
            WHERE IsActive = 1
            ORDER BY DivisionName;";

            using var conn = _context.GetConnection();
            return await conn.QueryAsync<DivisionDto>(sql);
        }

        public async Task<IEnumerable<DepartmentDto>> GetDepartmentsAsync()
        {
            const string sql = @"
            SELECT DepartmentId, DivisionId, DepartmentName
            FROM core.Department
            WHERE IsActive = 1
            ORDER BY DepartmentName;";

            using var conn = _context.GetConnection();
            return await conn.QueryAsync<DepartmentDto>(sql);
        }

        public async Task<IEnumerable<DepartmentDto>> GetDepartmentsByDivisionAsync(int divisionId)
        {
            const string sql = @"
            SELECT DepartmentId, DivisionId, DepartmentName
            FROM core.Department
            WHERE IsActive = 1
              AND DivisionId = @DivisionId
            ORDER BY DepartmentName;";

            using var conn = _context.GetConnection();
            return await conn.QueryAsync<DepartmentDto>(sql, new { DivisionId = divisionId });
        }

        public async Task<IEnumerable<DesignationDto>> GetDesignationsAsync()
        {
            const string sql = @"
            SELECT DesignationId, DesignationName
            FROM core.Designation
            WHERE IsActive = 1
            ORDER BY DesignationName;";

            using var conn = _context.GetConnection();
            return await conn.QueryAsync<DesignationDto>(sql);
        }

        public async Task<IEnumerable<PerspectiveDto>> GetPerspectivesAsync()
        {
            const string sql = @"
            SELECT PerspectiveId, PerspectiveName
            FROM core.Perspective
            WHERE IsActive = 1
            ORDER BY PerspectiveName;";

            using var conn = _context.GetConnection();
            return await conn.QueryAsync<PerspectiveDto>(sql);
        }
    }
}