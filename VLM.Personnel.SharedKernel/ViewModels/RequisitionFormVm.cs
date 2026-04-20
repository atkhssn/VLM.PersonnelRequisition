namespace VLM.Personnel.SharedKernel.ViewModels
{
    public class RequisitionFormVm
    {
        public long? RequisitionId { get; set; }
        public string? RequisitionNo { get; set; }
        public DateTime ReqDate { get; set; } = DateTime.Today;
        public int DivisionId { get; set; }
        public int DepartmentId { get; set; }
        public int DesignationId { get; set; }
        public int Vacancy { get; set; }
        public string Status { get; set; } = "Draft";
        public string? Description { get; set; }
        public List<RequisitionDetailFormVm> Details { get; set; } = new();
    }
}