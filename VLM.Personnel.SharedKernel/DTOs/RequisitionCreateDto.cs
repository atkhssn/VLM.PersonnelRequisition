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

    public class RequisitionDetailCreateDto
    {
        [Required]
        public int PerspectiveId { get; set; }

        [Required, MaxLength(500)]
        public string Objective { get; set; } = string.Empty;

        [MaxLength(200)]
        public string? KPI { get; set; }

        [Range(0, 100)]
        public decimal? WeightagePercentage { get; set; }

        [MaxLength(500)]
        public string? Remarks { get; set; }
    }
}