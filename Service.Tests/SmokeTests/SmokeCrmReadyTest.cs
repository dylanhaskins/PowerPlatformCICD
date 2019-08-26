using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.Xrm.Tooling.Connector;
using System.Net;

namespace CCMS.Core.Service.Tests.SmokeTests.SmokeCrmReadyTest

{
    [TestClass]
    [TestCategory("SmokeTests")]
    public class SmokeCrmReadyTest
    {
        private CrmServiceClient _client;
    
        [TestMethod]
        public void CrmServiceReady()
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
            Assert.IsTrue(TestSettings.Client.IsReady);     
        }        
    }
}
