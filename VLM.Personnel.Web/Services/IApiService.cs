using VLM.Personnel.SharedKernel.Common;

namespace VLM.Personnel.Web.Services
{
    public interface IApiService
    {
        Task<ApiResponse<T>?> GetAsync<T>(string url);
        Task<ApiResponse<T>?> PostAsync<T>(string url, object body);
        Task<ApiResponse<T>?> PutAsync<T>(string url, object body);
        Task<ApiResponse?> DeleteAsync(string url);
    }
}