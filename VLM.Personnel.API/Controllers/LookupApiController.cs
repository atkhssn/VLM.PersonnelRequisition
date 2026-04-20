using Microsoft.AspNetCore.Mvc;
using VLM.Personnel.Application.Interfaces.Services;
using VLM.Personnel.SharedKernel.Common;
using VLM.Personnel.SharedKernel.DTOs;

namespace VLM.Personnel.API.Controllers
{
    [ApiController]
    [Route("api/lookups")]
    [Produces("application/json")]
    public class LookupApiController : ControllerBase
    {
        private readonly ILookupService _service;

        public LookupApiController(ILookupService service)
        {
            _service = service;
        }

        [HttpGet("divisions")]
        public async Task<IActionResult> GetDivisions()
        {
            var result = await _service.GetDivisionsAsync();
            return Ok(result);
        }

        [HttpGet("departments")]
        public async Task<IActionResult> GetDepartments()
        {
            var result = await _service.GetDepartmentsAsync();
            return Ok(result);
        }

        [HttpGet("departments/by-division/{divisionId:int}")]
        public async Task<IActionResult> GetDepartmentsByDivision(int divisionId)
        {
            var result = await _service.GetDepartmentsByDivisionAsync(divisionId);
            return Ok(result);
        }

        [HttpGet("designations")]
        [ProducesResponseType(typeof(ApiResponse<IEnumerable<DesignationDto>>), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetDesignations()
        {
            var result = await _service.GetDesignationsAsync();
            return Ok(result);
        }

        [HttpGet("perspectives")]
        public async Task<IActionResult> GetPerspectives()
        {
            var result = await _service.GetPerspectivesAsync();
            return Ok(result);
        }
    }
}