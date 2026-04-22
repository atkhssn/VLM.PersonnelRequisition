using System.ComponentModel.DataAnnotations;

namespace VLM.Personnel.SharedKernel.DTOs
{
    public class RequisitionUpdateDto
    {
        [Required]
        public long RequisitionId { get; set; }

        [Required]
        public DateTime ReqDate { get; set; }

        [Required]
        public int DivisionId { get; set; }

        [Required]
        public int DepartmentId { get; set; }

        [Required]
        public int DesignationId { get; set; }

        [Range(1, int.MaxValue)]
        public int Vacancy { get; set; }

        [MaxLength(500)]
        public string? Description { get; set; }

        public string Status { get; set; } = "Draft";

        public List<RequisitionDetailUpdateDto> Details { get; set; } = new();

        public List<long> DeletedDetailIds { get; set; } = new();
    }

    public class RequisitionDetailUpdateDto
    {
        public long? RequisitionDetailId { get; set; }

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