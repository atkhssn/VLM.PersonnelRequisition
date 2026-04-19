using Microsoft.AspNetCore.Mvc;

namespace VLM.Personnel.API.Controllers
{
    public class RequisitionController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
