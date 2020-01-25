using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace PortalCompanionApp.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class SampleController : ControllerBase
    {
        [HttpGet]
        public ActionResult<string> Get()
        {
            var identity = User.Identity as ClaimsIdentity;
            var requester = identity?.FindFirst("http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier")?.Value;

            //return Contact Id
            return requester;
        }
    }
}
