namespace VLM.Personnel.SharedKernel.ViewModels
{
    public class RequisitionListVm
    {
        public long RequisitionId { get; set; }
        public string RequisitionNo { get; set; } = string.Empty;
        public DateTime ReqDate { get; set; }
        public string? DivisionName { get; set; }
        public string? DepartmentName { get; set; }
        public string? DesignationName { get; set; }
        public int Vacancy { get; set; }
        public string Status { get; set; } = string.Empty;
        public DateTime CreatedAt { get; set; }
    }
}