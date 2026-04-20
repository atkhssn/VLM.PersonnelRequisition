using VLM.Personnel.Domain.Common;

namespace VLM.Personnel.Domain.Entities
{
    public class RequisitionDetail : BaseEntity
    {
        public long RequisitionDetailId { get; set; }
        public long RequisitionId { get; set; }
        public int PerspectiveId { get; set; }
        public string Objective { get; set; } = string.Empty;
        public string? KPI { get; set; }
        public decimal? WeightagePercentage { get; set; }
        public string? Remarks { get; set; }
    }
}