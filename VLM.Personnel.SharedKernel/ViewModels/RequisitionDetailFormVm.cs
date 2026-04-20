namespace VLM.Personnel.SharedKernel.ViewModels
{
    public class RequisitionDetailFormVm
    {
        public long? RequisitionDetailId { get; set; }
        public int PerspectiveId { get; set; }
        public string? PerspectiveName { get; set; }
        public string Objective { get; set; } = string.Empty;
        public string? KPI { get; set; }
        public decimal? WeightagePercentage { get; set; }
        public string? Remarks { get; set; }
    }
}