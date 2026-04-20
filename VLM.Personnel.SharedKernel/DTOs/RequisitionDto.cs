namespace VLM.Personnel.SharedKernel.DTOs
{
    public class RequisitionDto
    {
        public long RequisitionId { get; set; }
        public string RequisitionNo { get; set; } = string.Empty;
        public DateTime ReqDate { get; set; }
        public int DivisionId { get; set; }
        public string? DivisionName { get; set; }
        public int DepartmentId { get; set; }
        public string? DepartmentName { get; set; }
        public int DesignationId { get; set; }
        public string? DesignationName { get; set; }
        public int Vacancy { get; set; }
        public string Status { get; set; } = string.Empty;
        public string? Description { get; set; }
        public DateTime CreatedAt { get; set; }
        public List<RequisitionDetailDto> Details { get; set; } = new();
    }
}