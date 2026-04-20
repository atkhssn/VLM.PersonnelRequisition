namespace VLM.Personnel.SharedKernel.DTOs
{
    public class RequisitionDetailDto
    {
        public long RequisitionDetailId { get; set; }
        public long RequisitionId { get; set; }
        public int PerspectiveId { get; set; }
        public string? PerspectiveName { get; set; }
        public string Objective { get; set; } = string.Empty;
        public string? KPI { get; set; }
        public decimal? WeightagePercentage { get; set; }
        public string? Remarks { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}