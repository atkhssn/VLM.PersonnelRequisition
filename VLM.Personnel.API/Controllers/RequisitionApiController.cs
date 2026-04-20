using Microsoft.AspNetCore.Mvc;
using VLM.Personnel.Application.Interfaces.Services;
using VLM.Personnel.SharedKernel.Common;
using VLM.Personnel.SharedKernel.DTOs;

namespace VLM.Personnel.API.Controllers
{
    [ApiController]
    [Route("api/requisitions")]
    [Produces("application/json")]
    public class RequisitionApiController : ControllerBase
    {
        private readonly IRequisitionService _service;

        public RequisitionApiController(IRequisitionService service)
        {
            _service = service;
        }

        // GET  api/requisitions
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var result = await _service.GetAllAsync();
            return Ok(result);
        }

        // GET  api/requisitions/{id}
        [HttpGet("{id:long}")]
        public async Task<IActionResult> GetById(long id)
        {
            var result = await _service.GetByIdAsync(id);
            if (!result.Success) return NotFound(result);
            return Ok(result);
        }

        // POST api/requisitions
        [HttpPost]
        public async Task<IActionResult> Create([FromBody] RequisitionCreateDto dto)
        {
            if (!ModelState.IsValid)
            {
                var errors = ModelState.Values
                    .SelectMany(v => v.Errors)
                    .Select(e => e.ErrorMessage)
                    .ToList();
                return BadRequest(ApiResponse.Fail("Validation failed.", errors));
            }

            var result = await _service.CreateAsync(dto);
            return CreatedAtAction(nameof(GetById), new { id = result.Data }, result);
        }

        // PUT  api/requisitions/{id}
        [HttpPut("{id:long}")]
        public async Task<IActionResult> Update(long id, [FromBody] RequisitionUpdateDto dto)
        {
            if (id != dto.RequisitionId)
                return BadRequest(ApiResponse.Fail("Route id and body RequisitionId do not match."));

            if (!ModelState.IsValid)
            {
                var errors = ModelState.Values
                    .SelectMany(v => v.Errors)
                    .Select(e => e.ErrorMessage)
                    .ToList();
                return BadRequest(ApiResponse.Fail("Validation failed.", errors));
            }

            var result = await _service.UpdateAsync(dto);
            if (!result.Success) return NotFound(result);
            return Ok(result);
        }

        // DELETE api/requisitions/{id}
        [HttpDelete("{id:long}")]
        public async Task<IActionResult> Delete(long id)
        {
            var result = await _service.DeleteAsync(id);
            if (!result.Success) return NotFound(result);
            return Ok(result);
        }

        // GET  api/requisitions/details/{detailId}
        [HttpGet("details/{detailId:long}")]
        public async Task<IActionResult> GetDetail(long detailId)
        {
            var result = await _service.GetDetailByIdAsync(detailId);
            if (!result.Success) return NotFound(result);
            return Ok(result);
        }

        // POST api/requisitions/{id}/details
        [HttpPost("{id:long}/details")]
        public async Task<IActionResult> AddDetail(long id, [FromBody] RequisitionDetailCreateDto dto)
        {
            if (!ModelState.IsValid)
            {
                var errors = ModelState.Values
                    .SelectMany(v => v.Errors)
                    .Select(e => e.ErrorMessage)
                    .ToList();
                return BadRequest(ApiResponse.Fail("Validation failed.", errors));
            }

            var result = await _service.AddDetailAsync(id, dto);
            return CreatedAtAction(nameof(GetDetail), new { detailId = result.Data }, result);
        }

        // PUT  api/requisitions/details/{detailId}
        [HttpPut("details/{detailId:long}")]
        public async Task<IActionResult> UpdateDetail(long detailId, [FromBody] RequisitionDetailCreateDto dto)
        {
            var result = await _service.UpdateDetailAsync(detailId, dto);
            if (!result.Success) return NotFound(result);
            return Ok(result);
        }

        // DELETE api/requisitions/details/{detailId}
        [HttpDelete("details/{detailId:long}")]
        public async Task<IActionResult> DeleteDetail(long detailId)
        {
            var result = await _service.DeleteDetailAsync(detailId);
            if (!result.Success) return NotFound(result);
            return Ok(result);
        }
    }
}