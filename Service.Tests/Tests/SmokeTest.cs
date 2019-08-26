using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.Xrm.Tooling.Connector;
using System;
using System.Net;
using System.Collections.Generic;
using System.Configuration;

namespace CCMS.Core.Service.Tests
{
    [TestClass]
    public class SmokeTest
    {
        private CrmServiceClient _client;
    
        [TestMethod]
        public void CrmServiceReady()
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
            _client = new CrmServiceClient(TestSettings.connection);
            Assert.IsTrue(_client.IsReady);     
        }        
    }
}
