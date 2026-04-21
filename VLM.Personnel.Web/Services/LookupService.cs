using VLM.Personnel.SharedKernel.DTOs;

namespace VLM.Personnel.Web.Services
{
    public class LookupService
    {
        private readonly IApiService _api;

        private List<DivisionDto>? _divisions;
        private List<DesignationDto>? _designations;
        private List<PerspectiveDto>? _perspectives;

        public LookupService(IApiService api) => _api = api;

        public async Task<List<DivisionDto>> GetDivisionsAsync()
        {
            if (_divisions is not null) return _divisions;
            var res = await _api.GetAsync<IEnumerable<DivisionDto>>("api/lookups/divisions");
            _divisions = res?.Data?.ToList() ?? new();
            return _divisions;
        }

        public async Task<List<DepartmentDto>> GetDepartmentsByDivisionAsync(int divisionId)
        {
            var res = await _api.GetAsync<IEnumerable<DepartmentDto>>($"api/lookups/departments/by-division/{divisionId}");
            return res?.Data?.ToList() ?? new();
        }

        public async Task<List<DesignationDto>> GetDesignationsAsync()
        {
            if (_designations is not null) return _designations;
            var res = await _api.GetAsync<IEnumerable<DesignationDto>>("api/lookups/designations");
            _designations = res?.Data?.ToList() ?? new();
            return _designations;
        }

        public async Task<List<PerspectiveDto>> GetPerspectivesAsync()
        {
            if (_perspectives is not null) return _perspectives;
            var res = await _api.GetAsync<IEnumerable<PerspectiveDto>>("api/lookups/perspectives");
            _perspectives = res?.Data?.ToList() ?? new();
            return _perspectives;
        }
    }
}