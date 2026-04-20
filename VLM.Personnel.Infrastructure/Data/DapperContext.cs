using System.Data;

namespace VLM.Personnel.Infrastructure.Data
{
    public class DapperContext
    {
        private readonly DbConnectionFactory _factory;

        public DapperContext(DbConnectionFactory factory)
        {
            _factory = factory;
        }

        public IDbConnection GetConnection() => _factory.CreateConnection();
    }
}