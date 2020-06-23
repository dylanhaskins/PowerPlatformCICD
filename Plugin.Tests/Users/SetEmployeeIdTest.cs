using System;
using FakeXrmEasy;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Plugin.Tests.Users
{
    [TestClass]
    [TestCategory("Users")]
    public class SetEmployeeIdTest
    {
        XrmFakedContext Context;
        XrmFakedTracingService TracingService;
        XrmFakedPluginExecutionContext PluginContext;

        [TestInitialize]
        public void TestInititalize()
        {
            Context = new XrmFakedContext();
            TracingService = Context.GetFakeTracingService();
            PluginContext = Context.GetDefaultPluginContext();

         }

        #region Test methods

        [TestMethod]
        public void When_TargetDoesntExist_Expect_TraceAndReturn()
        {
            string trace = TracingService.DumpTrace();
            Assert.IsTrue(trace.Contains(string.Format($"Target is missing. Exiting")));
        }

        #endregion
    }
}
