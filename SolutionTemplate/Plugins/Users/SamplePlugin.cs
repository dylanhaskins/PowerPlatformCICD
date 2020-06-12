using Microsoft.Xrm.Sdk;
using System;
using Common;
using Entities;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FeatureABC.Users

{
    [CrmPluginRegistration("Update",
    "systemuser", StageEnum.PreOperation, ExecutionModeEnum.Synchronous,
    "employeeid", "Users_SetEmployeeID on Pre Op Update", 1,
    IsolationModeEnum.Sandbox
    , Image1Type = ImageTypeEnum.PreImage
    , Image1Name = "PreImage"
    , Image1Attributes = "employeeid,domainname"
    , Description = "Sets the employee ID to the local-part of the email/username"
    , Id = "D0EED135-76FE-4BCA-BBA1-2435EBBBA6DA"
    )]
    [CrmPluginRegistration("Create",
    "systemuser", StageEnum.PreOperation, ExecutionModeEnum.Synchronous,
    "", "Users_SetEmployeeID on Pre Op Create", 1,
    IsolationModeEnum.Sandbox
    , Description = "Sets the employee ID to the local-part of the email/username"
    , Id = "4081D6EF-885B-43A4-89AA-F3F35F7C1057"
    )]
    public class SamplePlugin : BasePlugin
    {
        protected override void Execute(LocalPluginContext localcontext)
        {
            localcontext.Trace($"Entered Plugins.User.SamplePlugin.Execute {DateTime.UtcNow}");

            var user = localcontext.PluginExecutionContext.GetTarget<SystemUser>();
            var domainName = ImageHelpers.GetFinalAttribute(localcontext.PluginExecutionContext, "domainname", ImageHelpers.PreEntityImageName)?.ToString();

            var index = domainName?.IndexOf('@');
            user.EmployeeId = domainName?.Substring(0, index > 0 ? index.Value : 0);

            localcontext.Trace($"Exited Plugins.User.SamplePlugin.Execute {DateTime.UtcNow}");
        }
    }
}
