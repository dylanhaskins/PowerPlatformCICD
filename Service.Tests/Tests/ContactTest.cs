using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.Xrm.Sdk;
using Microsoft.Xrm.Tooling.Connector;
using System;
using System.Net;
using System.Collections.Generic;
using System.Configuration;

namespace CCMS.Core.Service.Tests
{
    [TestClass]
    public class ContactTest
    {
        private CrmServiceClient _client;
        private Entity contact;
        // Creates an entity called 'contact' with 2 mandatory fields and then checks that the values
        // in the backend are the same as the values set
        // This is just using in built functionality so not much of a valuable test. It's more just
        // to demonsrate how creating and reading entities of a D365 instance can be done
        [TestMethod]
        public void CreateWithMandatoryFields()
        {
            _client = new CrmServiceClient(TestSettings.connection);
            contact = new Entity("contact");
            contact["firstname"] = "Test";
            contact["lastname"] = "Last";
            Guid guid = _client.Create(contact);
            Assert.IsNotNull(guid);
            var list = new List<string>() { "firstname", "lastname" };
            var data = _client.GetEntityDataById("contact", guid, list);
            Assert.AreEqual("Test", data["firstname"]);
            Assert.AreEqual("Last", data["lastname"]);
        }
    }
}
