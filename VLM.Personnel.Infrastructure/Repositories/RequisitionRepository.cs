using Dapper;
using System.Data;
using VLM.Personnel.Application.Interfaces.Repositories;
using VLM.Personnel.Domain.Entities;
using VLM.Personnel.Infrastructure.Data;
using VLM.Personnel.SharedKernel.DTOs;

namespace VLM.Personnel.Infrastructure.Repositories
{
    public class RequisitionRepository : IRequisitionRepository
    {
        private readonly DapperContext _context;

        public RequisitionRepository(DapperContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<RequisitionListDto>> GetAllAsync()
        {
            const string sql = """
            SELECT
                r.RequisitionId,
                r.RequisitionNo,
                r.ReqDate,
                d.DivisionName,
                dep.DepartmentName,
                des.DesignationName,
                r.Vacancy,
                r.Status,
                r.CreatedAt
            FROM hr.Requisition r
            INNER JOIN core.Division     d   ON d.DivisionId     = r.DivisionId
            INNER JOIN core.Department   dep ON dep.DepartmentId = r.DepartmentId
            INNER JOIN core.Designation  des ON des.DesignationId= r.DesignationId
            ORDER BY r.RequisitionId DESC
            """;

            using var conn = _context.GetConnection();
            return await conn.QueryAsync<RequisitionListDto>(sql);
        }

        public async Task<RequisitionDto?> GetByIdAsync(long requisitionId)
        {
            const string sql = """
            SELECT
                r.RequisitionId,
                r.RequisitionNo,
                r.ReqDate,
                r.DivisionId,
                d.DivisionName,
                r.DepartmentId,
                dep.DepartmentName,
                r.DesignationId,
                des.DesignationName,
                r.Vacancy,
                r.Status,
                r.Description,
                r.CreatedAt
            FROM hr.Requisition r
            INNER JOIN core.Division     d   ON d.DivisionId     = r.DivisionId
            INNER JOIN core.Department   dep ON dep.DepartmentId = r.DepartmentId
            INNER JOIN core.Designation  des ON des.DesignationId= r.DesignationId
            WHERE r.RequisitionId = @RequisitionId;

            SELECT
                rd.RequisitionDetailId,
                rd.RequisitionId,
                rd.PerspectiveId,
                p.PerspectiveName,
                rd.Objective,
                rd.KPI,
                rd.WeightagePercentage,
                rd.Remarks,
                rd.CreatedAt
            FROM hr.RequisitionDetail rd
            INNER JOIN core.Perspective p ON p.PerspectiveId = rd.PerspectiveId
            WHERE rd.RequisitionId = @RequisitionId
            ORDER BY rd.RequisitionDetailId;
            """;

            using var conn = _context.GetConnection();
            using var multi = await conn.QueryMultipleAsync(sql, new { RequisitionId = requisitionId });

            var requisition = await multi.ReadSingleOrDefaultAsync<RequisitionDto>();
            if (requisition is null) return null;

            requisition.Details = (await multi.ReadAsync<RequisitionDetailDto>()).ToList();
            return requisition;
        }

        public async Task<long> CreateAsync(Requisition requisition, IEnumerable<RequisitionDetail> details)
        {
            const string insertRequisition = """
            DECLARE @NewSeq INT;
            DECLARE @Today NVARCHAR(8) = FORMAT(GETDATE(), 'yyMMdd');
            DECLARE @Prefix NVARCHAR(20) = 'R' + @Today + '-';

            SELECT @NewSeq = ISNULL(MAX(CAST(RIGHT(RequisitionNo, 4) AS INT)), 0) + 1
            FROM hr.Requisition WITH (UPDLOCK, HOLDLOCK)
            WHERE RequisitionNo LIKE @Prefix + '%';

            DECLARE @RequisitionNo NVARCHAR(50) = @Prefix + RIGHT('0000' + CAST(@NewSeq AS NVARCHAR), 4);

            INSERT INTO hr.Requisition 
                (RequisitionNo, ReqDate, DivisionId, DepartmentId, DesignationId, Vacancy, Status, Description)
            OUTPUT INSERTED.RequisitionId
            VALUES 
                (@RequisitionNo, @ReqDate, @DivisionId, @DepartmentId, @DesignationId, @Vacancy, @Status, @Description);
            """;

            const string insertDetail = """
            INSERT INTO hr.RequisitionDetail 
                (RequisitionId, PerspectiveId, Objective, KPI, WeightagePercentage, Remarks)
            VALUES 
                (@RequisitionId, @PerspectiveId, @Objective, @KPI, @WeightagePercentage, @Remarks);
            """;

            using var conn = _context.GetConnection();
            if (conn.State != ConnectionState.Open) conn.Open();
            using var tx = conn.BeginTransaction();

            try
            {
                var newId = await conn.ExecuteScalarAsync<long>(insertRequisition, new
                {
                    requisition.ReqDate,
                    requisition.DivisionId,
                    requisition.DepartmentId,
                    requisition.DesignationId,
                    requisition.Vacancy,
                    requisition.Status,
                    requisition.Description
                }, tx);

                if (newId <= 0)
                    throw new Exception("Failed to retrieve the new Requisition ID.");

                foreach (var detail in details)
                {
                    await conn.ExecuteAsync(insertDetail, new
                    {
                        RequisitionId = newId,
                        detail.PerspectiveId,
                        detail.Objective,
                        detail.KPI,
                        detail.WeightagePercentage,
                        detail.Remarks
                    }, tx);
                }

                tx.Commit();
                return newId;
            }
            catch
            {
                tx.Rollback();
                throw;
            }
        }

        public async Task<bool> UpdateAsync(Requisition requisition, IEnumerable<RequisitionDetail> details, IEnumerable<long> deletedDetailIds)
        {
            const string updateRequisition = """
            UPDATE hr.Requisition SET
                ReqDate        = @ReqDate,
                DivisionId     = @DivisionId,
                DepartmentId   = @DepartmentId,
                DesignationId  = @DesignationId,
                Vacancy        = @Vacancy,
                Status         = @Status,
                Description    = @Description
            WHERE RequisitionId = @RequisitionId;
            """;

            const string upsertDetail = """
            IF @RequisitionDetailId IS NULL OR @RequisitionDetailId = 0
            BEGIN
                INSERT INTO hr.RequisitionDetail
                    (RequisitionId, PerspectiveId, Objective, KPI, WeightagePercentage, Remarks)
                VALUES
                    (@RequisitionId, @PerspectiveId, @Objective, @KPI, @WeightagePercentage, @Remarks);
            END
            ELSE
            BEGIN
                UPDATE hr.RequisitionDetail SET
                    PerspectiveId       = @PerspectiveId,
                    Objective           = @Objective,
                    KPI                 = @KPI,
                    WeightagePercentage = @WeightagePercentage,
                    Remarks             = @Remarks
                WHERE RequisitionDetailId = @RequisitionDetailId
                  AND RequisitionId       = @RequisitionId;
            END
            """;

            const string deleteDetail = """
            DELETE FROM hr.RequisitionDetail
            WHERE RequisitionDetailId = @Id AND RequisitionId = @RequisitionId;
            """;

            using var conn = _context.GetConnection();
            conn.Open();
            using var tx = conn.BeginTransaction();

            try
            {
                var rows = await conn.ExecuteAsync(updateRequisition, new
                {
                    requisition.RequisitionId,
                    requisition.ReqDate,
                    requisition.DivisionId,
                    requisition.DepartmentId,
                    requisition.DesignationId,
                    requisition.Vacancy,
                    requisition.Status,
                    requisition.Description
                }, tx);

                if (rows == 0) { tx.Rollback(); return false; }

                foreach (var id in deletedDetailIds)
                {
                    await conn.ExecuteAsync(deleteDetail, new { Id = id, requisition.RequisitionId }, tx);
                }

                foreach (var detail in details)
                {
                    await conn.ExecuteAsync(upsertDetail, new
                    {
                        detail.RequisitionDetailId,
                        detail.RequisitionId,
                        detail.PerspectiveId,
                        detail.Objective,
                        detail.KPI,
                        detail.WeightagePercentage,
                        detail.Remarks
                    }, tx);
                }

                tx.Commit();
                return true;
            }
            catch
            {
                tx.Rollback();
                throw;
            }
        }

        public async Task<bool> DeleteAsync(long requisitionId)
        {
            const string sql = "DELETE FROM hr.Requisition WHERE RequisitionId = @RequisitionId;";
            using var conn = _context.GetConnection();
            var rows = await conn.ExecuteAsync(sql, new { RequisitionId = requisitionId });
            return rows > 0;
        }

        public async Task<RequisitionDetailDto?> GetDetailByIdAsync(long requisitionDetailId)
        {
            const string sql = """
            SELECT
                rd.RequisitionDetailId,
                rd.RequisitionId,
                rd.PerspectiveId,
                p.PerspectiveName,
                rd.Objective,
                rd.KPI,
                rd.WeightagePercentage,
                rd.Remarks,
                rd.CreatedAt
            FROM hr.RequisitionDetail rd
            INNER JOIN core.Perspective p ON p.PerspectiveId = rd.PerspectiveId
            WHERE rd.RequisitionDetailId = @RequisitionDetailId;
            """;

            using var conn = _context.GetConnection();
            return await conn.QuerySingleOrDefaultAsync<RequisitionDetailDto>(sql, new { RequisitionDetailId = requisitionDetailId });
        }

        public async Task<long> AddDetailAsync(RequisitionDetail detail)
        {
            const string sql = """
            INSERT INTO hr.RequisitionDetail
                (RequisitionId, PerspectiveId, Objective, KPI, WeightagePercentage, Remarks)
            VALUES
                (@RequisitionId, @PerspectiveId, @Objective, @KPI, @WeightagePercentage, @Remarks);
            SELECT CAST(SCOPE_IDENTITY() AS BIGINT);
            """;

            using var conn = _context.GetConnection();
            return await conn.ExecuteScalarAsync<long>(sql, new
            {
                detail.RequisitionId,
                detail.PerspectiveId,
                detail.Objective,
                detail.KPI,
                detail.WeightagePercentage,
                detail.Remarks
            });
        }

        public async Task<bool> UpdateDetailAsync(RequisitionDetail detail)
        {
            const string sql = """
            UPDATE hr.RequisitionDetail SET
                PerspectiveId       = @PerspectiveId,
                Objective           = @Objective,
                KPI                 = @KPI,
                WeightagePercentage = @WeightagePercentage,
                Remarks             = @Remarks
            WHERE RequisitionDetailId = @RequisitionDetailId;
            """;

            using var conn = _context.GetConnection();
            var rows = await conn.ExecuteAsync(sql, new
            {
                detail.RequisitionDetailId,
                detail.PerspectiveId,
                detail.Objective,
                detail.KPI,
                detail.WeightagePercentage,
                detail.Remarks
            });
            return rows > 0;
        }

        public async Task<bool> DeleteDetailAsync(long requisitionDetailId)
        {
            const string sql = "DELETE FROM hr.RequisitionDetail WHERE RequisitionDetailId = @RequisitionDetailId;";
            using var conn = _context.GetConnection();
            var rows = await conn.ExecuteAsync(sql, new { RequisitionDetailId = requisitionDetailId });
            return rows > 0;
        }
    }
}