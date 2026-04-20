using System.ComponentModel.DataAnnotations;

namespace VLM.Personnel.SharedKernel.DTOs
{
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