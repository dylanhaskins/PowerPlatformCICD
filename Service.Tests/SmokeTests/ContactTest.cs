using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.Xrm.Sdk;
using Microsoft.Xrm.Tooling.Connector;
using System;
using System.Collections.Generic;

namespace CCMS.Core.Service.Tests.SmokeTests.Person

{
    [TestClass] 
    [TestCategory("SmokeTests")]
    public class ContactTests
    {
        private CrmServiceClient _client = TestSettings.Client;
        private Entity contact;
        private Guid guid;        

        [TestInitialize]
        public void Setup()
        {
            contact = new Entity("contact");
            contact["firstname"] = "Edit";
            contact["lastname"] = "test";
            guid = _client.Create(contact);
            contact.Id = guid;
        }

        [TestMethod]
        public void EditFirstNameOfPerson()
        {
            contact["firstname"] = "New name";
            _client.Update(contact);
            var list = new List<string>() { "firstname" };
            var data = _client.GetEntityDataById("contact", guid, list);
            Assert.AreEqual("New name", data["firstname"]);

        }

        [TestMethod]
        public void EditLastNameOfPerson()
        {
            contact["lastname"] = "New last";
            _client.Update(contact);
            var list = new List<string>() { "lastname" };
            var data = _client.GetEntityDataById("contact", guid, list);
            Assert.AreEqual("New last", data["lastname"]);

        }

        [TestCleanup]
        public void Cleanup()
        {
            TestSettings.SystemClient.Delete("contact", guid);
        }
    }
}
