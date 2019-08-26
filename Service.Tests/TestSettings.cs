// This class has common test settings used globally across all tests.
using Microsoft.Xrm.Tooling.Connector;
using System.Configuration;

namespace CCMS.Core.Service.Tests
{    
    public static class TestSettings
    {
        private readonly static string username = ConfigurationManager.AppSettings["CrmUserName"];
        private readonly static string password = ConfigurationManager.AppSettings["CrmPassword"];
        private readonly static string SystemAdminUsername = ConfigurationManager.AppSettings["SystemAdminCrmUsername"];
        private readonly static string SystemAdminPassword = ConfigurationManager.AppSettings["SystemAdminCrmPassword"];
        private readonly static string url = ConfigurationManager.AppSettings["CrmUrl"];

        public static CrmServiceClient Client = new CrmServiceClient($"AuthType=Office365;Username={username};Password={password};Url={url};RequireNewInstance=True;SkipDiscovery=False");
        public static CrmServiceClient SystemClient = new CrmServiceClient($"AuthType=Office365;Username={SystemAdminUsername};Password={SystemAdminPassword};Url={url};RequireNewInstance=True;SkipDiscovery=False");
    }
}

// @{"CrmUrl"="$(CrmUrl)";"CrmUsername"="$(WorkforceManagerlogin)";"CrmPassword"="$(service-test-workforce-manager-password)";"SystemAdminCrmUsername"="$(SystemAdminLogin)";"SystemAdminCrmPassword"="$(service-test-system-admin-password)";}