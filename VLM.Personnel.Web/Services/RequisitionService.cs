using VLM.Personnel.SharedKernel.Common;
using VLM.Personnel.SharedKernel.DTOs;

namespace VLM.Personnel.Web.Services
{
    public class RequisitionService
    {
        private readonly IApiService _api;

        public RequisitionService(IApiService api) => _api = api;

        public Task<ApiResponse<IEnumerable<RequisitionListDto>>?> GetAllAsync()
            => _api.GetAsync<IEnumerable<RequisitionListDto>>("api/requisitions");

        public Task<ApiResponse<RequisitionDto>?> GetByIdAsync(long id)
            => _api.GetAsync<RequisitionDto>($"api/requisitions/{id}");

        public Task<ApiResponse<long>?> CreateAsync(RequisitionCreateDto dto)
            => _api.PostAsync<long>("api/requisitions", dto);

        public Task<ApiResponse<long>?> UpdateAsync(long id, RequisitionUpdateDto dto)
            => _api.PutAsync<long>($"api/requisitions/{id}", dto);

        public Task<ApiResponse?> DeleteAsync(long id)
            => _api.DeleteAsync($"api/requisitions/{id}");
    }
}