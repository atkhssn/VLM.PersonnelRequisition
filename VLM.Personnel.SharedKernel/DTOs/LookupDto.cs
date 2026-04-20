namespace VLM.Personnel.SharedKernel.DTOs
{
    public class DivisionDto
    {
        public int DivisionId { get; set; }
        public string DivisionName { get; set; } = string.Empty;
    }

    public class DepartmentDto
    {
        public int DepartmentId { get; set; }
        public int DivisionId { get; set; }
        public string DepartmentName { get; set; } = string.Empty;
    }

    public class DesignationDto
    {
        public int DesignationId { get; set; }
        public string DesignationName { get; set; } = string.Empty;
    }

    public class PerspectiveDto
    {
        public int PerspectiveId { get; set; }
        public string PerspectiveName { get; set; } = string.Empty;
    }
}