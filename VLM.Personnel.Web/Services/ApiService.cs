using System.Net.Http.Json;
using VLM.Personnel.SharedKernel.Common;

namespace VLM.Personnel.Web.Services
{
    public class ApiService : IApiService
    {
        private readonly HttpClient _http;

        public ApiService(HttpClient http)
        {
            _http = http;
        }

        public async Task<ApiResponse<T>?> GetAsync<T>(string url)
        {
            try { return await _http.GetFromJsonAsync<ApiResponse<T>>(url); }
            catch { return ApiResponse<T>.Fail("Network error."); }
        }

        public async Task<ApiResponse<T>?> PostAsync<T>(string url, object body)
        {
            try
            {
                var res = await _http.PostAsJsonAsync(url, body);
                return await res.Content.ReadFromJsonAsync<ApiResponse<T>>();
            }
            catch { return ApiResponse<T>.Fail("Network error."); }
        }

        public async Task<ApiResponse<T>?> PutAsync<T>(string url, object body)
        {
            try
            {
                var res = await _http.PutAsJsonAsync(url, body);
                return await res.Content.ReadFromJsonAsync<ApiResponse<T>>();
            }
            catch { return ApiResponse<T>.Fail("Network error."); }
        }

        public async Task<ApiResponse?> DeleteAsync(string url)
        {
            try
            {
                var res = await _http.DeleteAsync(url);
                return await res.Content.ReadFromJsonAsync<ApiResponse>();
            }
            catch { return ApiResponse.Fail("Network error."); }
        }
    }
}