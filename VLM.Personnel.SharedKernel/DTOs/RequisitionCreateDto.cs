using System.ComponentModel.DataAnnotations;

namespace VLM.Personnel.SharedKernel.DTOs
{
    public class RequisitionCreateDto
    {
        [Required]
        public DateTime ReqDate { get; set; }

        [Required]
        public int DivisionId { get; set; }

        [Required]
        public int DepartmentId { get; set; }

        [Required]
        public int DesignationId { get; set; }

        [Range(1, int.MaxValue, ErrorMessage = "Vacancy must be at least 1")]
        public int Vacancy { get; set; }

        [MaxLength(500)]
        public string? Description { get; set; }

        public List<RequisitionDetailCreateDto> Details { get; set; } = new();
    }
}